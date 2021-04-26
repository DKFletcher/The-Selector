//
//  WorksheetViewController.swift
//  WML
//
//  Created by Donald Fletcher on 31/01/2020.
//  Copyright © 2020 Donald Fletcher. All rights reserved.
//

import UIKit

class WorksheetViewController: UIViewController, UIGestureRecognizerDelegate, AccessBoardDelegate {
	
	@IBOutlet var topLeftLabel: UILabelInset!
	@IBOutlet var topRightLabel: UILabelInset!
	@IBOutlet var middleLeftLabel: UILabelInset!
	@IBOutlet var middleRightLabel: UILabelInset!
	@IBOutlet var bottomLeftLabel: UILabelInset!
	@IBOutlet var bottomRightLabel: UILabelInset!
	
	
	@IBOutlet var topLeftText: UITextView!
	@IBOutlet var topRightText: UITextView!
	@IBOutlet var middleLeftText: UITextView!
	@IBOutlet var middleRightText: UITextView!
	@IBOutlet var bottomLeftText: UITextView!
	@IBOutlet var bottomRightText: UITextView!
    
    let questionColorLight : UIColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    let questionColorDark : UIColor = #colorLiteral(red: 0.1294117719, green: 0.2156862766, blue: 0.06666667014, alpha: 1)
	
	var topLeftQA: QuestionAnswer!{
		didSet{
			topLeftLabel.text = topLeftQA.question
			topLeftText.text = topLeftQA.answer
//			topLeft.text = .text
		}
	}
	
	var topRightQA: QuestionAnswer!{
		didSet{
			topRightLabel.text = topRightQA.question
			topRightText.text = topRightQA.answer
		}
	}
	
	var middleLeftQA: QuestionAnswer!{
		didSet{
			middleLeftLabel.text = middleLeftQA.question
			middleLeftText.text = middleLeftQA.answer
		}
	}
	
	var middleRightQA: QuestionAnswer!{
		didSet{
			middleRightLabel.text = middleRightQA.question
			middleRightText.text = middleRightQA.answer
		}
	}
	
	var bottomLeftQA: QuestionAnswer!{
		didSet{
			bottomLeftLabel.text = bottomLeftQA.question
			bottomLeftText.text = bottomLeftQA.answer
		}
	}
	
	var bottomRightQA: QuestionAnswer!{
		didSet{
			bottomRightLabel.text = bottomRightQA.question
			bottomRightText.text = bottomRightQA.answer
		}
	}
	
	private var updateFromAccessBoard : QuestionAnswer? = nil
	
	@IBOutlet var labels: [UILabelInset]!
	
	private var worksheetDictionary : [UILabelInset : UITextView]{
		get{
			return [topLeftLabel : topLeftText,
							topRightLabel : topRightText,
							middleLeftLabel: middleLeftText,
							middleRightLabel: middleRightText,
							bottomLeftLabel: bottomLeftText,
							bottomRightLabel: bottomRightText]
		}
	}
	
	private var answersDictionary : [UILabelInset : QuestionAnswer]{
		get{
			return [topLeftLabel: topLeftQA,
							topRightLabel: topRightQA,
							middleLeftLabel: middleLeftQA,
							middleRightLabel: middleRightQA,
							bottomLeftLabel: bottomLeftQA,
							bottomRightLabel: bottomRightQA]
		}
	}
	
	@objc func accessBoard( _ sender : UITapGestureRecognizer){
		if let label = sender.view as? UILabelInset{
			updateFromAccessBoard = answersDictionary[label]
			performSegue(withIdentifier: "TextInputSegue", sender: label)
		}
	}
	
	func editText(for qa: QuestionAnswer) {
		if (updateFromAccessBoard == topLeftQA){
		}
		updateFromAccessBoard = QuestionAnswer(question: qa.question, answer: qa.answer)
		(tabBarController as? TabBarController)!.textToChange(text: qa)
	}
	
	weak var workSheet : Worksheet!
	var card : Card! {
		didSet{
			workSheet = card.emotion.qanda
			navigationItem.title = card.emotion.name
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		emotionImage.image = imageServer.get(image: card)
	}
	
	@IBOutlet var emotionImage : UIImageView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.navigationBar.isHidden = false
		navigationItem.largeTitleDisplayMode = .never
		
		emotionImage.image = imageServer.get(image: card)
		let longPress = UILongPressGestureRecognizer(target: self, action: #selector(closeImage(longPressGestureRecognizer: )))
		longPress.minimumPressDuration = 0.5
		longPress.numberOfTouchesRequired = 1
		longPress.delegate = self
		emotionImage.addGestureRecognizer(longPress)
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			title: "Print",
			style: .plain,
			target: self,
			action: #selector(action)
		)
		for label in labels {
			let tapGesture = UITapGestureRecognizer(target: self, action: #selector(accessBoard(_:)))
			label.addGestureRecognizer(tapGesture)
		}
		refresh()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
        for label in labels{
            if traitCollection.userInterfaceStyle == .light {
                label.backgroundColor = questionColorLight
            } else{
                label.backgroundColor = questionColorDark
            }
        }
		refresh()
	}
	
	private func refresh(){
		topLeftQA = card.emotion.qanda.topLeft[0]
		topRightQA = card.emotion.qanda.topRight[0]
		middleLeftQA = card.emotion.qanda.middleLeft[0]
		middleRightQA = card.emotion.qanda.middleRight[0]
		bottomLeftQA = card.emotion.qanda.bottomLeft[0]
		bottomRightQA = card.emotion.qanda.bottomRight[0]
	}
	
	@objc func action(){
		performSegue(withIdentifier: "PDFSegue", sender: card)
	}
	
	@objc func closeImage(longPressGestureRecognizer : UILongPressGestureRecognizer){
		if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
			performSegue(withIdentifier: "CloseSegue", sender: card)
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender segueVar: Any?) {
		if segue.identifier == "CloseSegue"{
			if let close = segue.destination as? CloseViewController{
				close.card = (segueVar as! Card)
			}
		}
		if segue.identifier == "TextInputSegue"{
			if let label = segueVar as? UILabelInset, let qa = answersDictionary[label], let textEditor = segue.destination as? AccessBoardViewController{
				textEditor.accessibleTextInputDelegate = self
				textEditor.questionAnswer = qa
				textEditor.textTitle = qa.question
				textEditor.contentText = qa.answer
				textEditor.card = card
			}
		}
		if segue.identifier == "PDFSegue"{
			if let pdfController = segue.destination as? PDFViewController{
				pdfController.card = (segueVar as! Card)
				pdfController.job = .WorkSheet
			}
		}
	}
}

class UILabelInset: UILabel{
	override func drawText(in rect: CGRect) {
		let insets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
		super.drawText(in: rect.inset(by: insets))
	}
}
