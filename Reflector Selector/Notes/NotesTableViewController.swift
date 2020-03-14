//
//  NotesTableViewController.swift
//  WML
//
//  Created by Donald Fletcher on 22/01/2020.
//  Copyright © 2020 Donald Fletcher. All rights reserved.
//

import UIKit

class NotesTableViewController: UITableViewController {
	
	var itemList: Worksheet!
	
	private func boxIDForSectionIndex(_ index: Int) -> BoxID? {
		return BoxID(rawValue: index)
	}
	
	var noteBookTitle : String = "" {
		didSet{
			navigationItem.title = noteBookTitle
			
			if let tabBar = UIApplication.shared.keyWindow?.rootViewController as? TabBarController {
				itemList = tabBar.cards.filter{$0.name == noteBookTitle}[0].emotion.qanda
			}
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.navigationBar.isHidden = false
		tableView.allowsMultipleSelectionDuringEditing = true
		navigationController?.navigationBar.prefersLargeTitles = true
		
		let addButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addContent))
		let trashButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(trashContent))
		navigationItem.rightBarButtonItems = [addButtonItem, trashButtonItem, editButtonItem]
		trashButtonItem.isEnabled = false
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}

	override func setEditing(_ editing: Bool, animated: Bool) {
		super.setEditing(editing, animated: true)
		tableView.setEditing(tableView.isEditing, animated: true)
		navigationItem.rightBarButtonItems![0].isEnabled = !editing
		navigationItem.rightBarButtonItems![1].isEnabled = editing
		if !editing {
			for sectionIndex in 0..<tableView.numberOfSections{
				for rowIndex in 0..<tableView.numberOfRows(inSection: sectionIndex){
					if let cell = tableView.cellForRow(at: IndexPath(row: rowIndex, section: sectionIndex)) as? ItemListTableViewCell{
						cell.itemListTextLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
						cell.checkMarkLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
					}
				}
			}
		}
	}
	
	@objc func trashContent(){
		if let selectedRows = tableView.indexPathsForSelectedRows {
			for indexPath in selectedRows {
				if let psychology = boxIDForSectionIndex(indexPath.section){
					let items = itemList.itemList(for: psychology)
					let rowToDelete = indexPath.row > items.count - 1 ? items.count - 1 : indexPath.row
					let item = items[rowToDelete]
					itemList.remove(item, from: psychology, at: rowToDelete)
				}
			}
			tableView.beginUpdates()
			tableView.deleteRows(at: selectedRows, with: .automatic)
			tableView.endUpdates()
		}
	}
	
	@objc func addContent(){
		performSegue(withIdentifier: "AddItemSegue", sender: nil)
	}
	
	@objc func addItem(){
		let newRowIndex = itemList.itemList(for: .topLeft).count
		_ = itemList.newItem()
		let indexPath = IndexPath(row: newRowIndex, section: 0)
		let indexPaths = [indexPath]
		tableView.insertRows(at: indexPaths, with: .automatic)
	}
	
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if let psychology = boxIDForSectionIndex(section) {
			return itemList.itemList(for: psychology).count
		}
		return 0
	}
	
	override func tableView(_ tableView: UITableView,  cellForRowAt indexPath: IndexPath) -> UITableViewCell{
		let cell = tableView.dequeueReusableCell(withIdentifier: "EmotionNoteItem", for: indexPath)
		if let boxID = boxIDForSectionIndex(indexPath.section){
			let items = itemList.itemList(for: boxID)
			let item = items[indexPath.row]
			(cell as? ItemListTableViewCell)!.itemListTextLabel.text = item.question
//			if item.checked {
//				(cell as? ItemListTableViewCell)!.checkMarkLabel.text = "✔︎"
//			} else {
//				(cell as? ItemListTableViewCell)!.checkMarkLabel.text = ""
//			}
		}
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
		if tableView.isEditing {
			if let cell = tableView.cellForRow(at: indexPath) as? ItemListTableViewCell{
				cell.itemListTextLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
				cell.checkMarkLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
			}
			return
		}
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if tableView.isEditing {
			if let cell = tableView.cellForRow(at: indexPath) as? ItemListTableViewCell{
				cell.itemListTextLabel.textColor = #colorLiteral(red: 0.2196078431, green: 0.2196078431, blue: 0.2588235294, alpha: 1)
				cell.checkMarkLabel.textColor = #colorLiteral(red: 0.2196078431, green: 0.2196078431, blue: 0.2588235294, alpha: 1)
			}
			return
		}
//		if let cell = tableView.cellForRow(at: indexPath){
//			if let psychology = boxIDForSectionIndex(indexPath.section) {
//				let item = itemList.itemList(for: psychology)[indexPath.row]
				//				item.toggleChecked()
//				itemList.relfelctorSelector(item: item)
//				configureCheckmark(for: cell, with: item)
				tableView.deselectRow(at: indexPath, animated: true)
//			}
//		}
	}
	
	override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
		if let boxID = boxIDForSectionIndex(indexPath.section) {
			let item = itemList.itemList(for: boxID)[indexPath.row]
			itemList.remove(item, from: boxID, at: indexPath.row)
			let indexPaths = [indexPath]
			tableView.deleteRows(at: indexPaths, with: .automatic)
		}
	}
	
	override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
		if let srcPsychology = boxIDForSectionIndex(sourceIndexPath.section),
			let destPsychology = boxIDForSectionIndex(destinationIndexPath.section) {
			let item = itemList.itemList(for: srcPsychology)[sourceIndexPath.row]
			itemList.move(item: item, from: srcPsychology, at: sourceIndexPath.row, to: destPsychology, at: destinationIndexPath.row)
		}
		tableView.reloadData()
	}
	
	
	func configureText(for cell: UITableViewCell, with item: QuestionAnswer){
		if let checkmarkCell = cell as? ItemListTableViewCell {
			checkmarkCell.itemListTextLabel.text = item.question
		}
	}
	
	func configureCheckmark(for cell: UITableViewCell, with item: EmotionItem){
		guard let checkmarkCell = cell as? ItemListTableViewCell else {
			return
		}
		for columnIndex in 0..<tableView.numberOfSections{
			for rowIndex in 0..<tableView.numberOfRows(inSection: columnIndex){
				if let cell = tableView.cellForRow(at: IndexPath(row: rowIndex, section: columnIndex)) as? ItemListTableViewCell{
					cell.itemListTextLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
					cell.checkMarkLabel.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
					cell.checkMarkLabel.text = ""
				}
			}
		}
		checkmarkCell.checkMarkLabel.text = "✔︎"
	}
	
	override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
		if identifier == "EditItemSegue"{
			if isEditing {return false}
		}
		return true
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "AddItemSegue"{
			if let addItemViewController = segue.destination as? ItemDetailViewController{
				addItemViewController.delegate = self
				addItemViewController.itemList = itemList
			}
		} else if segue.identifier == "EditItemSegue"{
			if let addItemViewController = segue.destination as? ItemDetailViewController{
				if let cell = sender as? UITableViewCell,
					let indexPath = tableView.indexPath(for: cell),
					let psychology = boxIDForSectionIndex(indexPath.section) {
					let item = itemList.itemList(for: psychology)[indexPath.row]
					//let item = itemList.items[indexPath.row]
					addItemViewController.itemToEdit = item
					addItemViewController.delegate = self
				}
			}
		}
	}
	
	override func numberOfSections(in tableView: UITableView) -> Int {
		return BoxID.allCases.count
	}
	
	
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		var title : String? = nil
		if let psychology = boxIDForSectionIndex(section) {
			switch psychology {
			case .topLeft : title = "Top Left"
			case .topRight : title = "Top Right"
			case .middleLeft : title = "Middle Left"
			case .middleRight : title = "Middle Right"
			case .bottomLeft : title = "Bottom Left"
			case .bottomRight : title = "Bottom Right"
			case .scraps : title = "Scraps"
			}
		}
		return title
	}
	
}

extension NotesTableViewController: ItemDetailViewControllerDelegate {
	
	func itemDetailViewController(_ controller: ItemDetailViewController, didFinishEdditing item: QuestionAnswer) {
		for boxID in BoxID.allCases {
			let currentList = itemList.itemList(for: boxID)
			if let index = currentList.index(of: item) {
				let indexPath = IndexPath(row: index, section: boxID.rawValue)
				if let cell = tableView.cellForRow(at: indexPath) {
					configureText(for: cell, with: item)
				}
			}
		}
		navigationController?.popViewController(animated: true)
	}
	
	func addItemViewControllerDidCancel(_ controller: ItemDetailViewController) {
		navigationController?.popViewController(animated: true)
	}
	
	func itemDetailViewController(_ controller: ItemDetailViewController, didFinishAdding item: QuestionAnswer) {
		navigationController?.popViewController(animated: true)
		let rowIndex = itemList.itemList(for: .topLeft).count - 1
		let indexPath = IndexPath(item: rowIndex, section: BoxID.topLeft.rawValue)
		let indexPaths = [indexPath]
		tableView.insertRows(at: indexPaths, with: .automatic)
	}
}
