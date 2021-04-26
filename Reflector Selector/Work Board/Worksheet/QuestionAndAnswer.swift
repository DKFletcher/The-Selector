//
//  QuestionAndAnswer.swift
//  WML
//
//  Created by Donald Fletcher on 05/02/2020.
//  Copyright © 2020 Donald Fletcher. All rights reserved.
//

import UIKit

protocol QuestionAnswerDelegate {
	func hasTapped(_ qANDa: QuestionAnswer, from box : QuestionAndAnswer)
}

protocol LabelHeightDelegate {
	func maximumLabelHeight(_ height : CGFloat)
}


class QuestionAndAnswer: UIView, QuestionAnswerDelegate, LabelHeightDelegate  {
	
	enum Alignment {
		case left, center, right
	}
	
	var questionLabelHeight : CGFloat = CGFloat(){
		didSet{
			questionLabel.frame = CGRect(
				x: 0,
				y: 0,
				width: bounds.width,
				height: questionLabelHeight
			)
			let font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
			let paragraphStyle = NSMutableParagraphStyle()
			paragraphStyle.alignment = .center
//			label.attributedText =
			questionLabel.attributedText = NSAttributedString(string: questionText, attributes : [.paragraphStyle: paragraphStyle, .font: font])
			answerLabel.frame = offset(
				from : CGRect(
					x: 0,
					y: questionLabel.bounds.height,
					width: bounds.width,
					height: ceil(bounds.height) - ceil(questionLabel.bounds.height)
				)
			)
		}
	}
	
	func orientation(){
		let questionLabelHeight = DynamicLabelSize.height(sizingString: questionText, font: UIFont.systemFont(ofSize: fontSize), width: self.frame.width)
		maximumLabelHeight(questionLabelHeight)
	}
	
	func maximumLabelHeight(_ height: CGFloat) {
		heightDelegate?.maximumLabelHeight(height)
	}
	
	func hasTapped(_ qANDa: QuestionAnswer, from box : QuestionAndAnswer) {
		delegate?.hasTapped(questionAnswer, from: self)
	}
	
	var delegate : QuestionAnswerDelegate?
	var heightDelegate : LabelHeightDelegate?
	
	var box : CGSize!
	
	var questionLabel : UILabelInset!
	
	var answerLabel : UITextView!
	
	var questionText : String = ""
	
	var answerText : String = ""{
		didSet{
			if let _ = answerLabel{
				answerLabel.attributedText = leftAttributedString(answerText)
			}
		}
	}
	
	var labelFont = UIFont.systemFont(ofSize: 16)
	
	var questionAnswer : QuestionAnswer!{
		didSet{
			questionText = questionAnswer.question
			answerText = questionAnswer.answer
		}
	}
	
	private var drawBox : Bool = true
	
	override func draw(_ rect: CGRect) {
		if drawBox {
			drawBox=false
			layoutLabels()
			self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(textInput(tapGestureRecognizer: ))))
		}
	}
	
	private func makeQA(){
		
	}
	
	
	func layoutLabels() {
		questionLabel = UILabelInset()
		
		answerLabel = UITextView()
		questionLabel =  makeLabel(questionText, background: #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1), .center)
		answerLabel =  makeLabel2(answerText, background: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), .left)
		let questionLabelHeight = DynamicLabelSize.height(sizingString: questionText, font: UIFont.systemFont(ofSize: fontSize), width: self.frame.width)
		questionLabel.frame = CGRect(
			x: 0,
			y: 0,
			width: bounds.width,
			height: questionLabelHeight
		)
		maximumLabelHeight(questionLabelHeight)
		answerLabel.frame = CGRect(
			x: 0,
			y: questionLabel.bounds.height,
			width: bounds.width,
			height: ceil(bounds.height) - ceil(questionLabel.bounds.height)
		)
	}
	
	@objc func textInput(tapGestureRecognizer: UITapGestureRecognizer){
		hasTapped(questionAnswer, from: self)
	}
	
	private func makeLabel(_ text : String, background color : UIColor, _ aligment : Alignment) -> UILabelInset{
		let label = UILabelInset()
		label.numberOfLines = 0
		label.contentMode = .scaleToFill
		label.backgroundColor = color
		var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .center
		label.attributedText = NSAttributedString(string: questionText, attributes : [.paragraphStyle: paragraphStyle, .font: font])
//		switch aligment{
//		case .left: label.attributedText = leftAttributedString(text)
//		case .right: label.attributedText = rightAttributedString(text)
//		case .center: label.attributedText = centeredAttributedString(text)
//		}
		label.lineBreakMode = .byWordWrapping
		addSubview(label)
		return label
	}


private func makeLabel2(_ text : String, background color : UIColor, _ aligment : Alignment) -> UITextView{
	let label = UITextView()
	label.isEditable = false
	label.isScrollEnabled = true
//	label.
	label.contentMode = .scaleToFill
	label.backgroundColor = color
	switch aligment{
	case .left: label.attributedText = leftAttributedString(text)
	case .right: label.attributedText = rightAttributedString(text)
	case .center: label.attributedText = centeredAttributedString(text)
	}
	addSubview(label)
	return label
}
}



//class UILabelInset: UILabel{
//	override func drawText(in rect: CGRect) {
//		let insets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
//		super.drawText(in: rect.inset(by: insets))
//	}
//}



class DynamicLabelSize {
	static func height(sizingString : String, font: UIFont, width: CGFloat) -> CGFloat{
		var font = UIFont.preferredFont(forTextStyle: .body).withSize(16)
//		font = UIFontMetrics(forTextStyle: .body).scaledFont (for: font)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .center
		let nsString : NSAttributedString = NSAttributedString(string: sizingString, attributes : [.paragraphStyle: paragraphStyle, .font: font])
		var currentHeight: CGFloat!
		
		let label = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
		
		label.attributedText = nsString
		label.font = font
		label.numberOfLines = 0
		label.sizeToFit()
		label.lineBreakMode = .byWordWrapping
		
		currentHeight = label.frame.height
		label.removeFromSuperview()
		
		return currentHeight + 5
	}
}
