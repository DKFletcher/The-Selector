//
//  SaveFileViewController.swift
//  Reflector Selector
//
//  Created by Donald Fletcher on 18/03/2020.
//  Copyright © 2020 whatmotivateslearning. All rights reserved.
//

import UIKit

class SaveFileViewController: UIViewController {
	var fileText : String!
	//	var data : Data!
	var nsData : NSData!
	
	
	@IBAction func trextFieldDidChange(_ sender: UITextField) {
		fileText = textField.text
	}
	
	
	@IBOutlet var textField: UITextField!
	
	@objc func preferredContentSizeChanged(_ notification : Notification){}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		NotificationCenter.default.addObserver(
			self,
			selector: #selector(preferredContentSizeChanged(_:)),
			name: UIContentSizeCategory.didChangeNotification,
			object: nil)
		
		
		navigationItem.leftBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .cancel,
			target: self,
			action: #selector(cancel))
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			barButtonSystemItem: .save,
			target: self,
			action: #selector(saveSelected))
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		textField.text = fileText
	}
	
	@objc func cancel(){
		self.navigationController?.popViewController(animated: true)
	}
	
	@objc func saveSelected(){
		fileToApplicationDirectory()
	}
}

extension SaveFileViewController{
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
		self.navigationController?.popViewController(animated: true)
	}
	
	
	private func fileToApplicationDirectory(){
		if fileExists(){
			chooseOverwrite()
		} else {
			saveInstruct()
		}
	}
	
	
	func chooseOverwrite() {
		let alert = UIAlertController(title: NSLocalizedString("A file with this name is already in the Selctor Reflector folder. Do you want to write over it? ", comment: ""), message:nil, preferredStyle: .alert)
		alert.modalPresentationStyle = .popover
		alert.popoverPresentationController?.sourceView = self.textField
		alert.addAction(UIAlertAction(title: NSLocalizedString("Yes", comment: ""), style: .default, handler: { (_) in
			self.saveInstruct()
		}))
		alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .default, handler: { (_) in
		}))
		present(alert, animated: true, completion: nil)
	}
	
	
	
	private func saveInstruct(){
		do {
			let directory : FileManager.SearchPathDirectory = .documentDirectory
			try savePDF(directory: directory, path: fileText)} catch {
				print(error)
		}
	}
	
	func save(directory: FileManager.SearchPathDirectory, name: String) throws {
		let documentData = nsData as Data
		let kindDirectoryURL = URL(fileURLWithPath: "test", relativeTo: FileManager.default.urls(for: directory, in: .userDomainMask)[0])
		try? FileManager.default.createDirectory(at: kindDirectoryURL, withIntermediateDirectories: true)
		try documentData.write(to: kindDirectoryURL.appendingPathComponent(name).appendingPathExtension("pdf"))
	}
	
	private func fileExists() -> Bool{
		let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
		let url = URL(fileURLWithPath: documentsPath)
		
		let fileManager = FileManager.default
		if let enumerator: FileManager.DirectoryEnumerator = fileManager.enumerator(atPath: url.path){
			
			while let element = enumerator.nextObject() as? String {
				print("element: \(element)")
				if element == fileText+".pdf"{
					return true
				}
			}
		}
		return false
	}
}
