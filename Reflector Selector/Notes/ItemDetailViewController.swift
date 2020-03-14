//
//  AddItemTableViewController.swift
//  WML
//
//  Created by Donald Fletcher on 22/01/2020.
//  Copyright © 2020 Donald Fletcher. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate : class {
	func addItemViewControllerDidCancel(_ controller: ItemDetailViewController)
	func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: QuestionAnswer)
	func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEdditing item: QuestionAnswer)
}

class ItemDetailViewController: UITableViewController {
	
	@IBOutlet var textField: UITextField!
	
	weak var itemList : Worksheet?
	
	var itemToEdit : QuestionAnswer!
	
	weak var delegate : ItemDetailViewControllerDelegate?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationItem.largeTitleDisplayMode = .never
//		let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelContent))
		let done = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneContent))
		done.isEnabled = false
//		navigationItem.leftBarButtonItems = [cancel]
		navigationItem.rightBarButtonItems = [done]
		textField.delegate = self
		
		if let item = itemToEdit {
			title = "Edit Item"
			textField.text = item.question
			
			done.isEnabled = true
		} else {
			textField.placeholder = "Write about emotion here..."
		}
	}
	
	@objc func cancelContent(){
		//		navigationController?.popViewController(animated: true)
		delegate?.addItemViewControllerDidCancel(self)
	}
	
	override func viewWillAppear(_ animated: Bool) {
//		textField.becomeFirstResponder()
	}
	
	@objc func doneContent(){
		//		navigationController?.popViewController(animated: true)
		if let item = itemToEdit, let text = textField.text {
			item.question = text
			delegate?.itemDetailViewController(self, didFinishEdditing: item)
			
		} else{
			if let item = itemList?.newItem(){
				if let textFieldText = textField.text {
					item.question = textFieldText
				}
//				item.checked = false
				delegate?.itemDetailViewController(self, didFinishAdding: item)
			}
		}
	}
	
	override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
		return nil
	}
}

extension ItemDetailViewController : UITextFieldDelegate{
	
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		textField.resignFirstResponder()
		//		doneContent()
		return false
	}
	
	func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		guard let oldText = textField.text,
			let stringRange = Range(range, in: oldText) else {
				return false
		}
		let newText = oldText.replacingCharacters(in: stringRange, with: 	string)
		if newText.isEmpty {
			navigationItem.rightBarButtonItems![0].isEnabled = false
		} else {
			navigationItem.rightBarButtonItems![0].isEnabled = true
		}
		return true
	}
}
