//
//  Collector.swift
//  Reflector Selector
//
//  Created by Donald Fletcher on 04/04/2020.
//  Copyright © 2020 whatmotivateslearning. All rights reserved.
//

import UIKit
import PDFKit

class Collector: Handbook{
	func collector(for card : Card, in cards: [Card]) -> Data{
		getIndex(book: cards)
		let data = renderer.pdfData { (context) in
			drawingPDF = context
			var titleString = "\(card.name)"
			if let name = learnerName{
				titleString = "\(name)\n\(card.name)"
			}
			if card.emotion.custom{
				customImage(for: card, using: titleString)
			} else{
				stockImage(using: titleString)
			}
			workSheet(for: card)
			if let emotionPDF = card.emotion.index.getPDFName(for: card.emotion.index.emotion.rawValue),
				let zonePDF = card.emotion.index.getPDFName(for: card.emotion.index.zone.rawValue),
				let quadPDF = card.emotion.index.getPDFName(for: card.emotion.index.quadrant.rawValue){
				createPage(destination: "nil", for: emotionPDF)
				createPage(destination: "nil", for: zonePDF)
				createPage(destination: "nil", for: quadPDF)
				createPage(destination: "nil", for: "The Big Picture")
			}
		}
		return data
	}
	
	func stockImage(using title: String){
		beginPage = true
		let attributes = getAttributes(fontSizeDelta: 10.0)
		let attributedString = NSAttributedString(string: title, attributes: attributes)
		let stringSize = getAttributedStringSize(attributedString)
		let stringRect = CGRect(origin: CGPoint(x: TypeSetConstants.margin, y: TypeSetConstants.header), size: stringSize)
		attributedString.draw(in: stringRect)
		if let image = UIImage(named: "Joy_3_1_750"){
			_=addImage(imageTop: TypeSetConstants.header+stringRect.height+200.0, image: image)
		}
	}
	
	func infoSheets(for card : Card, in cards: [Card]) -> Data{
		getIndex(book: cards)
		let data = renderer.pdfData { (context) in
			drawingPDF = context
			if let emotionPDF = card.emotion.index.getPDFName(for: card.emotion.index.emotion.rawValue),
				let zonePDF = card.emotion.index.getPDFName(for: card.emotion.index.zone.rawValue),
				let quadPDF = card.emotion.index.getPDFName(for: card.emotion.index.quadrant.rawValue){
				createPage(destination: "nil", for: emotionPDF)
				createPage(destination: "nil", for: zonePDF)
				createPage(destination: "nil", for: quadPDF)
			}
		}
		return data
	}
	
	func workSheet(for emotion: Card){
		beginPage = true
		emotion.emotion.qanda.sections().forEach{ $0.forEach {
			let test = $0.answer
			pagePosition = formatAnswerBook(drawing: drawingPDF, text: QuestionAnswer(question: $0.question, answer: test))
			}}
	}
}
