//
//  WorksheetCellSuperView.swift
//  WML
//
//  Created by Donald Fletcher on 03/02/2020.
//  Copyright © 2020 Donald Fletcher. All rights reserved.
//

import UIKit

protocol BoxDelegate{
	func hasTapped(_ qANDa: QuestionAnswer, from box : QuestionAndAnswer)
}

class WorksheetQuestionBox: UIView, UIGestureRecognizerDelegate, QuestionAnswerDelegate, LabelHeightDelegate {
	
	func maximumLabelHeight(_ height: CGFloat) {
		heightDelegate?.maximumLabelHeight(height)
	}
	
	func hasTapped(_ qANDa: QuestionAnswer, from box : QuestionAndAnswer) {
		delegate?.hasTapped(qANDa, from : box)
	}
	var questionLabelHeight : CGFloat = CGFloat() {
		didSet{
			for views in subviews {
				if let box = views as? QuestionAndAnswer{
					box.questionLabelHeight = questionLabelHeight
				}
			}
		}
	}
	func setQuestionLabel(height size : CGFloat){
		
	}
	
	var delegate : BoxDelegate?
	var heightDelegate: LabelHeightDelegate?
	
	var boxQandA : [QuestionAnswer]? {
		didSet{
			setNeedsDisplay()
			setNeedsLayout()
		}
	}
	
	var answer : UILabel!
	var question : UILabel!
	
	var boxID : BoxID = BoxID.topLeft
	
	lazy var labelHeight : CGFloat = {
		var height = CGFloat()
		for views in subviews {
			if let view = views as? QuestionAndAnswer{
			}
		}
		return height
	}()
	
	var answerString : String = ""{
		didSet{
			answer.text = answerString
		}
	}
	func resetFrame(){
		let qa = subviews[0] as! QuestionAndAnswer
		qa.frame = CGRect(
			x: bounds.minX,
			y: bounds.minY,
			width: bounds.width,
			height: bounds.height
		)
	}
	override func layoutSubviews() {
		guard let numberOfQuestions = boxQandA?.count else {
			return
		}
		if subviews.count == 1{
		}
		if numberOfQuestions > 0 &&  subviews.count == 0 {
				let qa = QuestionAndAnswer()
				qa.questionAnswer = boxQandA![0]
				qa.frame = CGRect(
					x: bounds.minX,
					y: bounds.minY,
					width: bounds.width,
					height: bounds.height
				)
				qa.delegate = self
				qa.heightDelegate = self
			addSubview(qa)
		}
	}
	
	func layOutLabels(){
		for views in subviews {
			if let box = views as? QuestionAndAnswer{
				box.layoutLabels()
			}
		}
	}
	
	func setAnswer(from text : String){
		answer.text = text
	}
	func setQuestionLabelHeight() -> CGFloat{
		let labelHeight = CGFloat()
		return labelHeight
	}
	private func makeLabel(using text : String, at box : CGRect, with color : UIColor) -> UILabel{
		let title = UILabel(frame: box)
		title.text = text
		title.backgroundColor = color
		return title
	}
}

