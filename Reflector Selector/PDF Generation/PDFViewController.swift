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
		
		work()
	}
	
	private func work(){
		switch job{
		case .WorkSheet :
			let heartHandbook = HeartHandbook(learner: (tabBarController as! TabBarController).learnerName)
			documentData = heartHandbook.createWork(for: card)
		case .InfoSheet :
			let heartHandbook = HeartHandbook(learner: (tabBarController as! TabBarController).learnerName)
			documentData = heartHandbook.createNote(for: card)
		case .Handbook :
			let heartHandbook = HeartHandbook(learner: (tabBarController as! TabBarController).learnerName)
			documentData = heartHandbook.create(from: (tabBarController as! TabBarController).cards)
		case .Logbook :
			let learnerLog = LearnerLog(learner: (tabBarController as! TabBarController).learnerName)
			documentData = learnerLog.create(from: (tabBarController as! TabBarController).cards)
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
			//			self.fileToApplicationDirectory()
		})
		alert.addAction(UIAlertAction(title: "Print", style: .default) { [unowned self] _ in
			self.printHardCopy()
			
		})
		
		alert.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
		
		present(alert, animated: true, completion: nil)
		
		
		
		
		
		
		//		if jobs == PDFViewController.Jobs.LearnerLog{
		//			fileToApplicationDirectory()
		//		} else {
		//			printHardCopy()
		//			fileToApplicationDirectory()
		//		}
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
	
	
	//	private func savePDF(directory : FileManager.SearchPathDirectory, path : String) throws{
	//		let pdfDirectoryURL = URL(
	//			fileURLWithPath: path,
	//			relativeTo: FileManager.default.urls(
	//				for: directory,
	//				in: .userDomainMask)[0]
	//		)
	//		try nsData.write(
	//			to: pdfDirectoryURL
	//				.appendingPathExtension("pdf"),
	//			options: .atomic
	//		)
	//	}
	//
	//
	//	private func fileToApplicationDirectory(){
	//			do {
	//				let fileName = (tabBarController as! TabBarController).learnerName ?? "RefelctorSelector"
	//				let directory : FileManager.SearchPathDirectory = .documentDirectory
	//				try savePDF(directory: directory, path: fileName)} catch {
	//				print(error)
	//			}
	//	}
	//
	//	func save(directory: FileManager.SearchPathDirectory, name: String) throws {
	//		let kindDirectoryURL = URL(fileURLWithPath: "test", relativeTo: FileManager.default.urls(for: directory, in: .userDomainMask)[0])
	//		try? FileManager.default.createDirectory(at: kindDirectoryURL, withIntermediateDirectories: true)
	//		try documentData.write(to: kindDirectoryURL.appendingPathComponent(name).appendingPathExtension("pdf"))
	//	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "FileSegue"{
			let name = (tabBarController as! TabBarController).learnerName ?? ""
			(segue.destination as! SaveFileViewController).fileText = name+" "+job.rawValue
			(segue.destination as! SaveFileViewController).nsData = nsData
		}
		print("preparation for save file")
	}
}

extension PDFViewController{
	enum Jobs: String {
		case WorkSheet = "Worksheet"
		case InfoSheet = "Information sheet"
		case Handbook = "Handbook"
		case Logbook = "Log Book"
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
