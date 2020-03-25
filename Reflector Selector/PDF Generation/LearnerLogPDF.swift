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
	func workSheet(for emotion: Card) -> Data{
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
			blankPage = false
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
			blankPage = false
				pagePosition += emotionHeight
				emotion.emotion.qanda.sections().forEach{ $0.forEach {
					let test = $0.answer
					pagePosition = formatAnswerBook(drawing: drawingPDF, text: QuestionAnswer(question: $0.question, answer: test))
					}}
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
			book.forEach{ emotion in
				pagePosition += TypeSetConstants.standardSpacing*5
				let emotionString = NSMutableAttributedString(string: emotion.name, attributes: headingAttributes)
				
				let emotionHeight = getAttributedStringHeight(emotionString)
				
				if emotionHeight + pagePosition > TypeSetConstants.pageHeight - TypeSetConstants.sectionStartFooter{
					beginPage = true
					pagePosition = TypeSetConstants.header
				}
				emotionString.draw(at: CGPoint(x: TypeSetConstants.margin, y: pagePosition))
				blankPage = false
				pagePosition += emotionHeight
				emotion.emotion.qanda.sections().forEach{ $0.forEach {
					let test = $0.answer
					pagePosition = formatAnswerBook(drawing: drawingPDF, text: QuestionAnswer(question: $0.question, answer: test))
				}}
				beginPage = true
				pagePosition = TypeSetConstants.header
			}
		}
		return data
	}
	
	internal func formatAnswerBook(drawing pdf: UIGraphicsPDFRendererContext, text block: QuestionAnswer)->CGFloat{
		func helper(startPosition: CGFloat,drawingPDF: UIGraphicsPDFRendererContext, qa: QuestionAnswer)->CGFloat{
			var returnPosition = startPosition
			var page = textBody3(to: qa.answer,for: qa.question,from: returnPosition)
			func help1 () -> CGFloat {
				beginPage = true
				returnPosition = TypeSetConstants.header
				return makeBodyItem(top: returnPosition + TypeSetConstants.standardSpacing, answer: page[1], question: qa.question)
			}
			
			func help2()-> CGFloat{
				returnPosition = makeBodyItem(top: returnPosition + TypeSetConstants.standardSpacing, answer: page[0], question: qa.question)
				beginPage = true
				returnPosition = TypeSetConstants.header
				return helper(startPosition: returnPosition, drawingPDF: drawingPDF, qa: QuestionAnswer(question: "", answer: page[1]))
			}
			
			return page.count == 2 ? page[0].count == 0 ? help1() : help2() :
				makeBodyItem(top: returnPosition + TypeSetConstants.standardSpacing, answer: page[0], question: qa.question)
		}
		return block.answer.count > 0 ? helper(startPosition: pagePosition, drawingPDF: pdf, qa: block) : blankAnswerBox(qa: block)
	}
	
	
	private func blankAnswerBox(qa: QuestionAnswer)->CGFloat{
		
		var returnPosition = pagePosition + TypeSetConstants.standardSpacing
		
		func onPage() -> CGFloat{
			let context = drawingPDF.cgContext
			context.setFillColor(UIColor.blue.cgColor)
			context.setLineWidth(TypeSetConstants.answerBoxLineWidth)
			let rect = CGRect(
				x: TypeSetConstants.margin,
				y: returnPosition,
				width: TypeSetConstants.pageWidth - TypeSetConstants.margin * 2,
				height: TypeSetConstants.answerBoxHeight)
			context.addRect(rect)
			context.drawPath(using: .stroke)
			blankPage = false
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
			let qAndA = NSMutableAttributedString(string: qa.question, attributes: boldAttributes)
			qAndA.draw(in: rect.insetBy(dx: TypeSetConstants.answerBoxTextInset, dy: TypeSetConstants.answerBoxTextInset))
			blankPage = false
			return returnPosition + TypeSetConstants.answerBoxHeight + TypeSetConstants.standardSpacing
		}
		
		func newPage() -> CGFloat{
			returnPosition = TypeSetConstants.header
			beginPage = true
			return onPage()
		}
		
		let qAndA = makeAttributedString(question: qa.question, answer: "")
		let qAndAHeight = getAttributedStringHeight(qAndA) + TypeSetConstants.answerBoxHeight
		return qAndAHeight + returnPosition < TypeSetConstants.pageHeight - TypeSetConstants.footer ? onPage() : newPage()
	}

	
}
