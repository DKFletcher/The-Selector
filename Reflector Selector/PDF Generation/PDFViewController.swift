//
//  PDFViewController.swift
//  WML
//
//  Created by Donald Fletcher on 30/12/2019.
//  Copyright © 2019 Donald Fletcher. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController, UIPrintInteractionControllerDelegate {
	
	//	var pdfView: PDFView!
	
	//	var pdfCreator : PDFCreator!
	
	
	@IBOutlet var pdfView: PDFView!
	
	
	var pdfDocument: PDFDocument!
	
	var card: Card!
	
	var nsData : NSData!
	
	var job : Jobs = .InfoSheet
	
	var documentData : Data!
	
	let folderName : String = "ReflectorSelector"
	
	var printButton : UIBarButtonItem!
	
	var fileButton : UIBarButtonItem!
	
	var printerName : String!
	
	let directories: [FileManager.SearchPathDirectory] = [
		.documentDirectory,
		.applicationSupportDirectory,
		.cachesDirectory
	]
	
	var additionalInfoForFileName : String = ""
	
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.navigationBar.isHidden = false
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		pdfView = PDFView()
		pdfView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(pdfView)
		
		pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
		pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
		pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
		pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .action,
			target: self,
			action: #selector(action))
		
		workFlow()
	}
	
	private func workFlow(){
		additionalInfoForFileName = ""
		switch job{
		case .WorkSheet :
			let log = LearnerLog(learner: (tabBarController as! TabBarController).learnerName)
			documentData = log.workSheet(for: card)
		case .InfoSheet :
			let collector = Collector(learner: (tabBarController as! TabBarController).learnerName)
			documentData = collector.infoSheets(for: card, in:(tabBarController as! TabBarController).cards)
			additionalInfoForFileName = " for \(card.name)"
		case .Handbook :
			let handbook = Handbook(learner: (tabBarController as! TabBarController).learnerName)
			documentData = handbook.handbook(from: (tabBarController as! TabBarController).cards)
		case .Logbook :
			let log = LearnerLog(learner: (tabBarController as! TabBarController).learnerName)
			documentData = log.logbook(from: (tabBarController as! TabBarController).cards)
		case .DoubleLong :
			let collector = Collector(learner: (tabBarController as! TabBarController).learnerName)
			documentData = collector.collector(for: card, in: (tabBarController as! TabBarController).cards)
//			let doubleLong = DoubleLong(learner: (tabBarController as! TabBarController).learnerName)
//			documentData = doubleLong.doubleLong(for: card)
		}
		
		if let data = documentData, let document = PDFDocument(data: data){
			nsData = NSData(data: data)
			pdfDocument = document
			pdfView.displayMode = .singlePageContinuous
			pdfView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
			pdfView.scaleFactor = 0.25
			pdfView.document = document
		}
	}
	
	@objc func action(){
		let message = NSLocalizedString(job.rawValue, comment: "")
		let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
		alert.addAction(UIAlertAction(title: "Save", style: .default) { [unowned self] _ in
			self.performSegue(withIdentifier: "FileSegue", sender: nil)
		})
		alert.addAction(UIAlertAction(title: "Print", style: .default) { [unowned self] _ in
			self.printHardCopy()
			
		})
		
		alert.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
		
		present(alert, animated: true, completion: nil)
	}
	
	func printHardCopy(){
		
		let printCompletionHandler: UIPrintInteractionController.CompletionHandler = { (controller, success, error) -> Void in
			if success {
				// Printed successfully
				// Remove file here ...
				self.documentData = nil
			} else {
				self.documentData = nil
				// Printing failed, report error ...
			}
		}
		
		let printController = UIPrintInteractionController.shared
		printController.showsNumberOfCopies = false
		printController.delegate = self
		
		
		let printInfo = UIPrintInfo(dictionary : nil)
		//		printInfo.duplex = .longEdge
		printInfo.orientation = .portrait
		printInfo.outputType = .general
		printInfo.jobName = (tabBarController as! TabBarController).learnerName ?? job.rawValue
		
		
		printController.printInfo = printInfo
		printController.printingItem = documentData
		printController.present(animated : true, completionHandler : printCompletionHandler)
	}
	
	
	func pdfOnScreen(pdf card: Card){
		guard let path = Bundle.main.url(forResource: card.name, withExtension: "pdf") else {
			print("PDFViewController, pdf url definition fail for \(card.name)")
			return
		}
		if let document = PDFDocument(url: path) {
			pdfView.document = document
			pdfDocument = document
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "FileSegue"{
			let name = (tabBarController as! TabBarController).learnerName ?? ""
			(segue.destination as! SaveFileViewController).fileText = name+" "+job.rawValue+additionalInfoForFileName
			(segue.destination as! SaveFileViewController).nsData = nsData
		}
		print("preparation for save file")
	}
}

extension PDFViewController{
	enum Jobs: String {
		case WorkSheet = "Worksheet"
		case InfoSheet = "Information Pack"
		case Handbook = "Handbook"
		case Logbook = "Log Book"
		case DoubleLong = "Double Long Pack"
	}
}


extension UIAlertController {
	override open func viewDidLoad() {
		super.viewDidLoad()
		pruneNegativeWidthConstraints()
	}
	
	func pruneNegativeWidthConstraints() {
		for subView in self.view.subviews {
			for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
				subView.removeConstraint(constraint)
			}
		}
	}
}
