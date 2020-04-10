//
//  AccessableInputViewController.swift
//  WML
//
//  Created by Donald Fletcher on 05/02/2020.
//  Copyright © 2020 Donald Fletcher. All rights reserved.
//

import UIKit
protocol AccessableTextInputViewControllerDelegate{
	func editText(for question : QuestionAnswer)
//	func rotation()
}
class AccessableInputViewController: UIViewController, AccessableTextInputViewControllerDelegate, UITextViewDelegate {

	var accessibleTextInputDelegate : AccessableTextInputViewControllerDelegate?

	@IBOutlet var textView: UITextView!
	
	var contentText : String = ""
	
	var boxID : BoxID = .scraps
	
	var textTitle : String = ""
	
	var questionAnswer : QuestionAnswer!
	
	var card : Card!
	
	func editText(for question: QuestionAnswer) {
		accessibleTextInputDelegate?.editText(for: question)
	}

//	func rotation(){
//		accessibleTextInputDelegate?.rotation()
//	}

	
	override func viewWillAppear(_ animated: Bool) {
		textView.becomeFirstResponder()
		super.viewWillAppear(animated)
		textView.text = contentText
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
		NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
	}
	
	@objc func keyboardWillAppear(_ notification:NSNotification) {
		let d = notification.userInfo!
		var r = (d[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
		r = self.textView.convert(r, from:nil)
		self.textView.contentInset.bottom = r.size.height
//		self.textView.verticalScrollIndicatorInsets.bottom = r.size.height
		
	}
	
	@objc func keyboardWillDisappear(_ notification:NSNotification) {
		let contentInsets = UIEdgeInsets.zero
		self.textView.contentInset = contentInsets
//		self.textView.verticalScrollIndicatorInsets = contentInsets
	}
	
	override func viewWillDisappear(_ animated: Bool) {
		super.viewWillDisappear(animated)
		questionAnswer.answer = contentText
		editText(for: questionAnswer)
		NotificationCenter.default.removeObserver(self)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		navigationItem.largeTitleDisplayMode = .never
//		textTitle
		navigationItem.title = textTitle
		textView.delegate = self
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			title: "Print",
			style: .plain,
			target: self,
			action: #selector(action)
		)
	}
	
	@objc func action(){
		performSegue(withIdentifier: "PDFSegue", sender: card)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender stetson: Any?) {
		if segue.identifier == "PDFSegue"{
			if let pdfController = segue.destination as? PDFViewController{
				pdfController.card = card
				pdfController.job = .FocusSheet
				pdfController.focusSheet = questionAnswer
			}
		}
	}
	func textViewDidChange(_ textView: UITextView){
		if let text = textView.text {
			contentText = text
			questionAnswer.answer=contentText
			editText(for: questionAnswer)
		}
	}
}
