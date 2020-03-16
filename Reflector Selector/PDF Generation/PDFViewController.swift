//
//  PDFViewController.swift
//  WML
//
//  Created by Donald Fletcher on 30/12/2019.
//  Copyright © 2019 Donald Fletcher. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
	
//	var pdfView: PDFView!
	
//	var pdfCreator : PDFCreator!
	
	
	@IBOutlet var pdfView: PDFView!
	
	
	var pdfDocument: PDFDocument!
	
	var card: Card!
	
	var nsData : NSData!
	
	var jobs : Jobs = .InfoSheet
	
	var documentData : Data!
	
	let folderName : String = "ReflectorSelector"
	
	var printButton : UIBarButtonItem!
	
	var fileButton : UIBarButtonItem!
	
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
		
		self.printButton = UIBarButtonItem(image: UIImage(named: "printer"), style: .plain, target: self, action: #selector(action))
		self.fileButton = UIBarButtonItem(barButtonSystemItem: .organize, target: self, action: #selector(action))
		
		
		work()
	}
	
	private func work(){
		switch jobs{
		case .WorkSheet :
			let heartHandbook = HeartHandbook(learner: (tabBarController as! TabBarController).learnerName)
			documentData = heartHandbook.createWork(for: card)
			
		case .InfoSheet :
			let heartHandbook = HeartHandbook(learner: (tabBarController as! TabBarController).learnerName)
			documentData = heartHandbook.createNote(for: card)
		case .HeartHandbook :
			let heartHandbook = HeartHandbook(learner: (tabBarController as! TabBarController).learnerName)
			documentData = heartHandbook.create(from: (tabBarController as! TabBarController).cards)
		case .LearnerLog :
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
		
		if jobs == PDFViewController.Jobs.LearnerLog{
			navigationItem.rightBarButtonItem = fileButton
//			printTapped()
		} else {
			navigationItem.rightBarButtonItem = printButton
//			printHardCopy()
		}
	}
	
	@objc func action(){
		if jobs == PDFViewController.Jobs.LearnerLog{
			fileToApplicationDirectory()
		} else {
//			printHardCopy()
			fileToApplicationDirectory()
		}
	}
	
	func printHardCopy(){
		pdfView = nil
		let printController = UIPrintInteractionController.shared
		let printInfo = UIPrintInfo(dictionary : nil)
		printInfo.duplex = .longEdge
		printInfo.outputType = .general
		printInfo.jobName = "Test"
		printController.printInfo = printInfo
		printController.printingItem = documentData
		printController.present(animated : true, completionHandler : nil)
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
	
	private func savePDF(directory : FileManager.SearchPathDirectory, path : String) throws{
		let pdfDirectoryURL = URL(
			fileURLWithPath: path,
			relativeTo: FileManager.default.urls(
				for: directory,
				in: .userDomainMask)[0]
		)
		try nsData.write(
			to: pdfDirectoryURL
				.appendingPathExtension("pdf"),
			options: .atomic
		)
	}
	
	
	private func fileToApplicationDirectory(){
			do {
				let fileName = (tabBarController as! TabBarController).learnerName ?? "RefelctorSelector"
				let directory : FileManager.SearchPathDirectory = .documentDirectory
				try savePDF(directory: directory, path: fileName)} catch {
				print(error)
			}
	}
	
	func save(directory: FileManager.SearchPathDirectory, name: String) throws {
		let kindDirectoryURL = URL(fileURLWithPath: "test", relativeTo: FileManager.default.urls(for: directory, in: .userDomainMask)[0])
		try? FileManager.default.createDirectory(at: kindDirectoryURL, withIntermediateDirectories: true)
		try documentData.write(to: kindDirectoryURL.appendingPathComponent(name).appendingPathExtension("pdf"))
	}
}

extension PDFViewController{
	enum Jobs{
		case WorkSheet, InfoSheet, HeartHandbook, LearnerLog
	}
}
