//
//  LearnerLogPDF.swift
//  Reflector Selector
//
//  Created by Donald Fletcher on 11/03/2020.
//  Copyright © 2020 whatmotivateslearning. All rights reserved.
//

import UIKit
import PDFKit

class LearnerLog : PDFSuperView{
	
	override init(learner name: String?) {
		super.init(learner: name)
	}


	func focusQuestion(for question: QuestionAnswer, partOf emotion: Card) -> Data{
		let name = learnerName ?? ""
		let boldFont = UIFont(name: "Chalkduster", size: TypeSetConstants.tagLineFontSize)
		let bodyFont = UIFont(name: "Chalkduster", size: TypeSetConstants.bodyFontSize)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .left
		paragraphStyle.lineBreakMode = .byWordWrapping
		let headingAttributes: [NSAttributedString.Key: Any] = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: boldFont!,
			NSAttributedString.Key.foregroundColor: UIColor.black]
		let boldAttributes: [NSAttributedString.Key: Any] = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: boldFont!,
			NSAttributedString.Key.foregroundColor: UIColor.black]
		let bodyAttributes: [NSAttributedString.Key: Any] = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: bodyFont!,
			NSAttributedString.Key.foregroundColor: UIColor.black]
		let title = NSMutableAttributedString(string: "Reflector Selector Focus Question\n", attributes: boldAttributes)
		let answerAttributedString = NSAttributedString(string: name+" ", attributes: bodyAttributes)
		//		let answerAttributedString = NSAttributedString(string: formattedDate, attributes: bodyAttributes)
		title.append(answerAttributedString)
		let image = UIImage(named: "Joy_3") ?? UIImage()
		let imageRect = CGRect(
			x: TypeSetConstants.pageWidth - image.size.width/2-TypeSetConstants.margin,
			y: TypeSetConstants.header,
			width: image.size.width/2,
			height: image.size.height/2
		)
		let renderer = UIGraphicsPDFRenderer(
			bounds: CGRect(
				x: 0.0,
				y: 0.0,
				width: TypeSetConstants.pageWidth,
				height: TypeSetConstants.pageHeight))
		let data = renderer.pdfData { (context) in
			drawingPDF = context
			beginPage = true
			
			image.draw(in: imageRect)
			pagePosition = image.size.height+5*TypeSetConstants.standardSpacing
			title.draw(at: CGPoint(x: TypeSetConstants.margin, y: TypeSetConstants.header))
			//			book.forEach{ emotion in
			pagePosition += TypeSetConstants.standardSpacing*5
			let emotionString = NSMutableAttributedString(string: emotion.name, attributes: headingAttributes)
			
			let emotionHeight = getAttributedStringHeight(emotionString)
			
			if emotionHeight + pagePosition > TypeSetConstants.pageHeight - TypeSetConstants.sectionStartFooter{
				beginPage = true
				pagePosition = TypeSetConstants.header
			}
			emotionString.draw(at: CGPoint(x: TypeSetConstants.margin, y: pagePosition))
			pagePosition += emotionHeight
			_=autoreleasepool {
				formatAnswerBook(drawing: drawingPDF, text: question)
			}
		}
		return data
	}

	
	func workSheet(for emotion: Card) -> Data{
		let name = learnerName ?? ""
		let boldFont = UIFont(name: "Chalkduster", size: TypeSetConstants.tagLineFontSize)
		let bodyFont = UIFont(name: "Chalkduster", size: TypeSetConstants.bodyFontSize)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .left
		paragraphStyle.lineBreakMode = .byWordWrapping
		let headingAttributes: [NSAttributedString.Key: Any] = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: boldFont!,
			NSAttributedString.Key.foregroundColor: UIColor.black]
		let boldAttributes: [NSAttributedString.Key: Any] = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: boldFont!,
			NSAttributedString.Key.foregroundColor: UIColor.black]
		let bodyAttributes: [NSAttributedString.Key: Any] = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: bodyFont!,
			NSAttributedString.Key.foregroundColor: UIColor.black]
		let title = NSMutableAttributedString(string: "Reflector Selector Workbook\n", attributes: boldAttributes)
		let answerAttributedString = NSAttributedString(string: name+" ", attributes: bodyAttributes)
		//		let answerAttributedString = NSAttributedString(string: formattedDate, attributes: bodyAttributes)
		title.append(answerAttributedString)
		let image = UIImage(named: "Joy_3") ?? UIImage()
		let imageRect = CGRect(
			x: TypeSetConstants.pageWidth - image.size.width/2-TypeSetConstants.margin,
			y: TypeSetConstants.header,
			width: image.size.width/2,
			height: image.size.height/2
		)
		let renderer = UIGraphicsPDFRenderer(
			bounds: CGRect(
				x: 0.0,
				y: 0.0,
				width: TypeSetConstants.pageWidth,
				height: TypeSetConstants.pageHeight))
		let data = renderer.pdfData { (context) in
			
			drawingPDF = context
			beginPage = true

			image.draw(in: imageRect)
			pagePosition = image.size.height+5*TypeSetConstants.standardSpacing
			title.draw(at: CGPoint(x: TypeSetConstants.margin, y: TypeSetConstants.header))
			//			book.forEach{ emotion in
			pagePosition += TypeSetConstants.standardSpacing*5
			let emotionString = NSMutableAttributedString(string: emotion.name, attributes: headingAttributes)
			
			let emotionHeight = getAttributedStringHeight(emotionString)
			
			if emotionHeight + pagePosition > TypeSetConstants.pageHeight - TypeSetConstants.sectionStartFooter{
				beginPage = true
				pagePosition = TypeSetConstants.header
			}
			emotionString.draw(at: CGPoint(x: TypeSetConstants.margin, y: pagePosition))
			pagePosition += emotionHeight
			autoreleasepool {
				emotion.emotion.qanda.sections().forEach{ $0.forEach {
					let test = $0.answer
					pagePosition = formatAnswerBook(drawing: drawingPDF, text: QuestionAnswer(question: $0.question, answer: test))
					}}
			}
		}
		return data
	}
	
	
	func logbook(from book: [Card]) -> Data{
		//		let date = Date()
		//		let format = DateFormatter()
		//		format.dateFormat = "dd-MM-yyyy"
		//		let formattedDate = format.string(from: date)
		let name = learnerName ?? ""
		//		let headingFont = UIFont(name: "Chalkduster", size: PDFCreator.TypeSetConstants.headingFontSize)
		let boldFont = UIFont(name: "Chalkduster", size: TypeSetConstants.tagLineFontSize)
		let bodyFont = UIFont(name: "Chalkduster", size: TypeSetConstants.bodyFontSize)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .left
		paragraphStyle.lineBreakMode = .byWordWrapping
		let headingAttributes: [NSAttributedString.Key: Any] = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: boldFont!,
			NSAttributedString.Key.foregroundColor: UIColor.black]
		let boldAttributes: [NSAttributedString.Key: Any] = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: boldFont!,
			NSAttributedString.Key.foregroundColor: UIColor.black]
		let bodyAttributes: [NSAttributedString.Key: Any] = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: bodyFont!,
			NSAttributedString.Key.foregroundColor: UIColor.black]
		let title = NSMutableAttributedString(string: "Reflector Selector Worksheet\n", attributes: boldAttributes)
		let answerAttributedString = NSAttributedString(string: name+" ", attributes: bodyAttributes)
		//		let answerAttributedString = NSAttributedString(string: formattedDate, attributes: bodyAttributes)
		title.append(answerAttributedString)
		let image = UIImage(named: "Joy_3") ?? UIImage()
		let imageRect = CGRect(
			x: TypeSetConstants.pageWidth - image.size.width/2-TypeSetConstants.margin,
			y: TypeSetConstants.header,
			width: image.size.width/2,
			height: image.size.height/2
		)
		let renderer = UIGraphicsPDFRenderer(
			bounds: CGRect(
				x: 0.0,
				y: 0.0,
				width: TypeSetConstants.pageWidth,
				height: TypeSetConstants.pageHeight))
		let data = renderer.pdfData { (context) in

			drawingPDF = context
			beginPage = true
			image.draw(in: imageRect)
			pagePosition = image.size.height+5*TypeSetConstants.standardSpacing
			title.draw(at: CGPoint(x: TypeSetConstants.margin, y: TypeSetConstants.header))
			var firstPage = true
			book.forEach{ emotion in
				if !firstPage{
					beginPage = true
					firstPage = false
				}
				pagePosition += TypeSetConstants.standardSpacing*5
				let emotionString = NSMutableAttributedString(string: emotion.name, attributes: headingAttributes)
				
				let emotionHeight = getAttributedStringHeight(emotionString)
				
				if emotionHeight + pagePosition > TypeSetConstants.pageHeight - TypeSetConstants.sectionStartFooter{
					beginPage = true
					pagePosition = TypeSetConstants.header
				}
				emotionString.draw(at: CGPoint(x: TypeSetConstants.margin, y: pagePosition))
				pagePosition += emotionHeight
				autoreleasepool {
					emotion.emotion.qanda.sections().forEach{ $0.forEach {
//						print("\($0.question)")
						let test = $0.answer
						pagePosition = formatAnswerBook(drawing: drawingPDF, text: QuestionAnswer(question: $0.question, answer: test))
						}}
				}
				firstPage = false
				pagePosition = TypeSetConstants.header
			}
		}
		return data
	}
}
