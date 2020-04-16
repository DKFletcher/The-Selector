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
		let initDocument = initiateDocument(for: "Focus Question\n")
		let title = initDocument.0
		let image = initDocument.2
		let imageRect = initDocument.3
		let renderer = initDocument.4
		
		let data = renderer.pdfData { (context) in
			drawingPDF = context
			beginPage = true
			image.draw(in: imageRect)
			let titleHeight = getTitleHeight(title, image: imageRect.width)
			title.draw(in:
				CGRect(
					x: TypeSetConstants.margin,
					y: TypeSetConstants.header,
					width: TypeSetConstants.pageWidth - 2*TypeSetConstants.margin - imageRect.width,
					height: titleHeight))
			pagePosition += getAttributedStringHeight(title)+TypeSetConstants.standardSpacing
			let boldFont = UIFont.systemFont(
				ofSize: TypeSetConstants.bodyFontSize,
				weight: .heavy)
			let paragraphStyle = NSMutableParagraphStyle()
			paragraphStyle.alignment = .left
			paragraphStyle.lineBreakMode = .byWordWrapping
			let boldAttributes: [NSAttributedString.Key: Any] = [
				NSAttributedString.Key.paragraphStyle: paragraphStyle,
				NSAttributedString.Key.font: boldFont,
				NSAttributedString.Key.foregroundColor: UIColor.darkGray]
			let qAndA = NSAttributedString(string: question.question, attributes: boldAttributes)
			_=autoreleasepool {
				qAndA.draw(at: CGPoint(x: TypeSetConstants.margin, y: pagePosition))
			}
		}
		return data
	}

	
	func getTitleHeight(_ nsAttributedString: NSMutableAttributedString, image width : CGFloat) ->CGFloat{
		let textTest = nsAttributedString.boundingRect(
			with: CGSize(
				width: TypeSetConstants.pageWidth - TypeSetConstants.margin*2 - width,
				height: CGFloat.greatestFiniteMagnitude
			),
			options: [.usesLineFragmentOrigin, .usesFontLeading],
			context: nil)
		return ceil(textTest.height)
	}
	
	
	
	func workSheet(for emotion: Card) -> Data{
		let initDocument = initiateDocument(for: emotion.name)
		let title = initDocument.0
		let image = initDocument.2
		let imageRect = initDocument.3
		let renderer = initDocument.4
		
		let data = renderer.pdfData { (context) in
			drawingPDF = context
			beginPage = true

			image.draw(in: imageRect)
			let titleHeight = getTitleHeight(title, image: imageRect.width)
			title.draw(in:
				CGRect(
					x: TypeSetConstants.margin,
					y: TypeSetConstants.header,
					width: TypeSetConstants.pageWidth - 2*TypeSetConstants.margin - imageRect.width,
					height: titleHeight))
			pagePosition = getAttributedStringHeight(title) + TypeSetConstants.header
			autoreleasepool {
				emotion.emotion.qanda.sections().forEach{ $0.forEach {
					let test = $0.answer
					pagePosition = formatAnswerBook(drawing: drawingPDF, text: QuestionAnswer(question: $0.question, answer: test))
					}}
			}
		}
		return data
	}
	
	
	func logbook(from book: [Card], in pages: AbstractionLayerForWorkbook) -> Data{
		let initDocument = initiateDocument(for: "Workbook")
		let title = initDocument.0
		let headingAttributes = initDocument.1
		let image = initDocument.2
		let imageRect = initDocument.3
		let renderer = initDocument.4
		
		let data = renderer.pdfData { (context) in

			drawingPDF = context
			beginPage = true
			image.draw(in: imageRect)
			let titleHeight = getTitleHeight(title, image: imageRect.width)
			title.draw(in:
				CGRect(
					x: TypeSetConstants.margin,
					y: TypeSetConstants.header,
					width: TypeSetConstants.pageWidth - 2*TypeSetConstants.margin - imageRect.width,
					height: titleHeight))
			pagePosition = getAttributedStringHeight(title)+TypeSetConstants.header
			var firstPage = true
			book.forEach{ emotion in
				for page in pages.workBook{
					if page.name == emotion.name && page.included{
						if !firstPage{
							beginPage = true
							firstPage = false
						}
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
						firstPage = false
						pagePosition = TypeSetConstants.header/2
					}
				}
			}
		}
		return data
	}
	
	private func initiateDocument(for title: String) ->(NSMutableAttributedString,[NSAttributedString.Key: Any],UIImage, CGRect, UIGraphicsPDFRenderer){
		
		
		let boldFont = UIFont.systemFont(
			ofSize: TypeSetConstants.bodyFontSize,
			weight: .heavy)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .left
		paragraphStyle.lineBreakMode = .byWordWrapping
		let boldAttributes: [NSAttributedString.Key: Any] = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: boldFont,
			NSAttributedString.Key.foregroundColor: UIColor.black]
		
		
		
		
		var titleAttributedString = NSMutableAttributedString()
		if let name = learnerName{
			titleAttributedString = NSMutableAttributedString(string: "\(name) - \(title)", attributes: boldAttributes)
		} else {
			titleAttributedString = NSMutableAttributedString(string: title, attributes: boldAttributes)
		}
		
		
		
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
		return (titleAttributedString,boldAttributes, image, imageRect, renderer)
	}
}
