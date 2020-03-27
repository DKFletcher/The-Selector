//
//  WorksheetViewController.swift
//  WML
//
//  Created by Donald Fletcher on 31/01/2020.
//  Copyright © 2020 Donald Fletcher. All rights reserved.
//

import UIKit

class WorksheetViewController: UIViewController, UIGestureRecognizerDelegate, AccessableTextInputViewControllerDelegate, BoxDelegate, LabelHeightDelegate {
	
	func maximumLabelHeight(_ height: CGFloat) {
		heightArray.append(height)
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
	var heightArray : [CGFloat] = []{
		didSet{
			if heightArray.count == workSheet.numberOfQuestions{
				heightArray.sort()
				let h = heightArray[heightArray.count-1]
				topLeft.questionLabelHeight = h
				topRight.questionLabelHeight = h
				middleLeft.questionLabelHeight = h
				middleRight.questionLabelHeight = h
				bottomLeft.questionLabelHeight = h
				bottomRight.questionLabelHeight = h
				heightArray = []
			}
		}
	}
	
	private var boxUpdate : QuestionAndAnswer?
	
	func hasTapped(_ qANDa: QuestionAnswer, from  box : QuestionAndAnswer) {
		boxUpdate = box
		performSegue(withIdentifier: "TextInputSegue", sender: qANDa)
	}
	
	func editText(for question: QuestionAnswer) {
		(tabBarController as? TabBarController)!.textToChange(text: question)
		if let box = boxUpdate{
			box.answerText = question.answer
//			box.layouLabels()
//			boxUpdate = nil
		}
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
		rotation()
	}
	
//	override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//		super.viewWillTransition(to: size, with: coordinator)
//		if UIDevice.current.orientation.isLandscape {
//			print("Landscape")
//		} else {
//			print("Portrait")
//		}
//	}
	
	
	
	@IBOutlet var emotionImage : UIImageView!
	
	@IBOutlet var topLeft: WorksheetQuestionBox!
	@IBOutlet var topRight: WorksheetQuestionBox!
	@IBOutlet var middleLeft: WorksheetQuestionBox!
	@IBOutlet var middleRight: WorksheetQuestionBox!
	@IBOutlet var bottomLeft: WorksheetQuestionBox!
	@IBOutlet var bottomRight: WorksheetQuestionBox!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		navigationController?.navigationBar.isHidden = false
		navigationItem.largeTitleDisplayMode = .never
		
		emotionImage.image = imageServer.get(image: card)
		
		topLeft.boxQandA = card.emotion.qanda.topLeft
		topRight.boxQandA = card.emotion.qanda.topRight
		middleLeft.boxQandA = card.emotion.qanda.middleLeft
		middleRight.boxQandA = card.emotion.qanda.middleRight
		bottomLeft.boxQandA = card.emotion.qanda.bottomLeft
		bottomRight.boxQandA = card.emotion.qanda.bottomRight
		
		topLeft.boxID = BoxID.topLeft
		topRight.boxID = BoxID.topRight
		middleLeft.boxID = BoxID.middleLeft
		middleRight.boxID = BoxID.middleRight
		bottomLeft.boxID = BoxID.bottomLeft
		bottomRight.boxID = BoxID.bottomRight
		
		let longPress = UILongPressGestureRecognizer(target: self, action: #selector(closeImage(longPressGestureRecognizer: )))
		longPress.minimumPressDuration = 0.5
		longPress.numberOfTouchesRequired = 1
		longPress.delegate = self
		emotionImage.addGestureRecognizer(longPress)
		
		topLeft.delegate = self
		topRight.delegate = self
		middleLeft.delegate = self
		middleRight.delegate = self
		bottomLeft.delegate = self
		bottomRight.delegate = self
		
		topLeft.heightDelegate = self
		topRight.heightDelegate = self
		middleLeft.heightDelegate = self
		middleRight.heightDelegate = self
		bottomLeft.heightDelegate = self
		bottomRight.heightDelegate = self
		
		navigationItem.rightBarButtonItem = UIBarButtonItem(
			title: "Print",
			style: .plain,
			target: self,
			action: #selector(action)
		)
		
//		(tabBarController as! TabBarController).workSheetViewController = self
		NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
	}

	@objc func action(){
		performSegue(withIdentifier: "PDFSegue", sender: card)
	}
	
	@objc func textInput(tapGestureRecognizer: UITapGestureRecognizer){
		if let sender = tapGestureRecognizer.view as? WorksheetQuestionBox{
			if let label = sender.question, let text = label.text, text.count > 0 {
				performSegue(withIdentifier: "TextInputSegue", sender: sender)
			}
		}
	}
	
	@objc func closeImage(longPressGestureRecognizer : UILongPressGestureRecognizer){
		if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
			performSegue(withIdentifier: "CloseSegue", sender: card)
		}
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender card: Any?) {
		if segue.identifier == "CloseSegue"{
			if let close = segue.destination as? CloseViewController{
				close.card = (card as! Card)
			}
		}
		if segue.identifier == "TextInputSegue"{
			if let textEditor = segue.destination as? AccessableInputViewController{
				textEditor.accessibleTextInputDelegate = self
				textEditor.questionAnswer = card as? QuestionAnswer
				textEditor.textTitle = (card as? QuestionAnswer)!.question
				textEditor.contentText = (card as? QuestionAnswer)!.answer
			}
		}
		if segue.identifier == "PDFSegue"{
			if let pdfController = segue.destination as? PDFViewController{
				pdfController.card = card as! Card
				pdfController.job = .WorkSheet
			}
		}
	}
}

//extension WorksheetViewController : UITextFieldDelegate{
//}





extension WorksheetViewController {
	@objc func rotated() {
		rotation()
	}
	
	func rotation(){
		setForRotation(for: topLeft)
		setForRotation(for: topRight)
		setForRotation(for: middleLeft)
		setForRotation(for: middleRight)
		setForRotation(for: bottomLeft)
		setForRotation(for: bottomRight)
		
	}
	
	func setForRotation(for box: WorksheetQuestionBox){
		box.resetFrame()
		(box.subviews[0] as! QuestionAndAnswer).orientation()
	}
}


