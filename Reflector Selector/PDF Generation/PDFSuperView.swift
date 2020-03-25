//
//  PDFSuperView.swift
//  Reflector Selector
//
//  Created by Donald Fletcher on 11/03/2020.
//  Copyright © 2020 whatmotivateslearning. All rights reserved.
//


import UIKit
import PDFKit

class PDFSuperView {
	
	var pagePosition : CGFloat = TypeSetConstants.header {
		didSet{
			if pagePosition > TypeSetConstants.pageHeight
				- TypeSetConstants.header
				- TypeSetConstants.footer{
				pagePosition = TypeSetConstants.header
				beginPage = true
			}
		}
	}
	
	var learnerName : String?
	
	var beginPage : Bool! {
		didSet{
			if !blankPage{
				drawingPDF.beginPage()
				blankPage = true
			}
		}
	}
	
	var blankPage : Bool = true
	
	internal var drawingPDF : UIGraphicsPDFRendererContext!
	
	init(learner name : String?) {
		if let learnName = name{
			self.learnerName = learnName
		}
	}
	
	//textBody - Interogates the string to be set and the available space to produce an array that has as its first value a string that fits the available space on page. The function needs to return the following format of array:
	//1) ["block"] a block that fits onto the available space of one page.
	//2) ["","block"] a single line block that does not fit onto the current page.
	//3) ["block1","block2"] block1 fits onto the current page, block2 is recursively carried over onto new pages.
	
	func textBody2(to answer: String, for question: String, from start: CGFloat)->[String]{
		var maxSplits = 1
		let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
		let components = answer.components(separatedBy: chararacterSet)
		let words = components.filter { !$0.isEmpty }.count
		var pageBreak = [String(), String()]
		if !itemToFitPage(top: start, question: question, answer: answer ){
			for _ in 0..<words{
				if let subString = answer.split(separator: " ", maxSplits: maxSplits, omittingEmptySubsequences: true).last{
					let prePredicate = String(subString)
					if let regex1 = try? NSRegularExpression(pattern: prePredicate){
						let prePredicateRemoved = answer.removePredicate(regEx: regex1)
						if !itemToFitPage(top: start, question: question, answer: prePredicateRemoved ){
							if let pageBreakSubString = answer.split(separator: " ", maxSplits: maxSplits-1, omittingEmptySubsequences: true).last{
								let predicate = String(pageBreakSubString)
								if let regex2 = try? NSRegularExpression(pattern: predicate){
									let predicateRemoved = answer.removePredicate(regEx: regex2)
									pageBreak = [predicateRemoved, predicate]
									break
								}
							}
						}
					}
				}
				maxSplits+=1
			}
			return pageBreak
		} else {
			return [answer]
		}
	}
	
	
	func textBody3(to oldAnswer: String, for question: String, from start: CGFloat)->[String]{
		var answer = ""
		var onceThru = false
		oldAnswer.components(separatedBy: CharacterSet.newlines).forEach{newline in
			answer+=newline+" "
			if onceThru{
				onceThru = false
				answer = " \n"+answer
			}
		}
		var maxSplits = 1
		let chararacterSet = CharacterSet.whitespacesAndNewlines.union(.punctuationCharacters)
		let components = answer.components(separatedBy: chararacterSet)
		let words = components.filter { !$0.isEmpty }.count
		var testAnswer = ""
		var remainder = ""
		if !itemToFitPage(top: start, question: question, answer: answer ){
			for _ in 0..<words{
				if let subString = answer.split(separator: " ", maxSplits: maxSplits, omittingEmptySubsequences: false).last{
					maxSplits+=1
					let predicate = String(subString)
					let predicateRange=answer.range(of: predicate)
					testAnswer = answer
					testAnswer.removeSubrange(predicateRange!)
					if !itemToFitPage(top: start, question: question, answer: testAnswer ){
						if let solutionString = answer.split(separator: " ", maxSplits: maxSplits-2, omittingEmptySubsequences: false).last{
							remainder = String(solutionString)
							let predicateRange=answer.range(of: remainder)
							testAnswer = answer
							testAnswer.removeSubrange(predicateRange!)
						break
						}
					}
				}
				
			}
			return [testAnswer,remainder]
		} else {
			return [answer]
		}
	}
	
	
	func textBody(to split: String, for question: String, from start: CGFloat)->[String]{
		var index = split.endIndex
		var oneLineCount = 0
		
		func recursiveFit(textIntoSpace: [String]) -> [String]{
			oneLineCount += 1
			guard let notASingleWord = textIntoSpace[0].lastIndex(of: " ") else {
				return oneLineCount > 2 ? ["",split] : [textIntoSpace[0]]
			}
			index = notASingleWord
			return itemToFitPage(top: start, question: question, answer: textIntoSpace[0]) ?
				textIntoSpace[0].count == textIntoSpace[1].count ? [textIntoSpace[0]] : textIntoSpace :
				recursiveFit(textIntoSpace: [String(textIntoSpace[0].prefix(upTo: index)),textIntoSpace[1]])
		}
		
		let fit = recursiveFit(textIntoSpace: [split,split])
		return fit.count == 1 ? fit :
			fit[0].count != 0 ? [fit[0], String(split.suffix(from: index ))] : ["",split]
	}
	
	func makeAttributedString(question: String, answer: String) -> NSMutableAttributedString{
		let boldFont = UIFont.systemFont(
			ofSize: TypeSetConstants.bodyFontSize,
			weight: .heavy)
		let bodyFont = UIFont.systemFont(
			ofSize: TypeSetConstants.bodyFontSize,
			weight: .regular)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .left
		paragraphStyle.lineBreakMode = .byWordWrapping
		let boldAttributes: [NSAttributedString.Key: Any] = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: boldFont,
			NSAttributedString.Key.foregroundColor: UIColor.darkGray]
		let bodyAttributes: [NSAttributedString.Key: Any] = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: bodyFont,
			NSAttributedString.Key.foregroundColor: UIColor.black]
		let qAndA = NSMutableAttributedString(string: question + "\n", attributes: boldAttributes)
		let answerAttributedString = NSAttributedString(string: answer, attributes: bodyAttributes)
		qAndA.append(answerAttributedString)
		return qAndA
	}
	
	func getAttributedStringHeight(_ nsAttributedString: NSMutableAttributedString ) ->CGFloat{
		let qAndATest = nsAttributedString.boundingRect(
			with: CGSize(
				width: TypeSetConstants.pageWidth - TypeSetConstants.margin*2,
				height: CGFloat.greatestFiniteMagnitude
			),
			options: [.usesLineFragmentOrigin, .usesFontLeading],
			context: nil)
		return ceil(qAndATest.height)
	}
	
	func itemToFitPage(
		top: CGFloat,
		question: String,
		answer: String) -> Bool{
		
		let qAndA = makeAttributedString(question: question, answer: answer)
		let qAndAHeight = getAttributedStringHeight(qAndA)
		if qAndAHeight + top < TypeSetConstants.pageHeight - TypeSetConstants.footer{
		}
		return qAndAHeight + top < TypeSetConstants.pageHeight - TypeSetConstants.footer
	}
	
	func makeBodyItem(top: CGFloat,
										answer: String,
										question: String,
										isNewPage: Bool = false) -> CGFloat {
		guard answer.count != 0 else {return top}
		let qAndA = makeAttributedString(question: question, answer: answer)
		let qAndAHeight = getAttributedStringHeight(qAndA)
		let textRect = CGRect(
			x: TypeSetConstants.margin,
			y: top,
			width: TypeSetConstants.pageWidth - TypeSetConstants.margin*2,
			height: qAndAHeight)
		qAndA.draw(in: textRect)
		blankPage = false
		return textRect.origin.y + textRect.size.height
	}
	
//	private func blankAnswerBox(qa: QuestionAnswer)->CGFloat{
//
//		var returnPosition = pagePosition + TypeSetConstants.standardSpacing
//
//		func onPage() -> CGFloat{
//			let context = drawingPDF.cgContext
//			context.setFillColor(UIColor.blue.cgColor)
//			context.setLineWidth(TypeSetConstants.answerBoxLineWidth)
//			let rect = CGRect(
//				x: TypeSetConstants.margin,
//				y: returnPosition,
//				width: TypeSetConstants.pageWidth - TypeSetConstants.margin * 2,
//				height: TypeSetConstants.answerBoxHeight)
//			context.addRect(rect)
//			context.drawPath(using: .stroke)
//			blankPage = false
//			let boldFont = UIFont.systemFont(
//				ofSize: TypeSetConstants.bodyFontSize,
//				weight: .heavy)
//			let paragraphStyle = NSMutableParagraphStyle()
//			paragraphStyle.alignment = .left
//			paragraphStyle.lineBreakMode = .byWordWrapping
//			let boldAttributes: [NSAttributedString.Key: Any] = [
//				NSAttributedString.Key.paragraphStyle: paragraphStyle,
//				NSAttributedString.Key.font: boldFont,
//				NSAttributedString.Key.foregroundColor: UIColor.darkGray]
//			let qAndA = NSMutableAttributedString(string: qa.question, attributes: boldAttributes)
//			qAndA.draw(in: rect.insetBy(dx: TypeSetConstants.answerBoxTextInset, dy: TypeSetConstants.answerBoxTextInset))
//			blankPage = false
//			return returnPosition + TypeSetConstants.answerBoxHeight + TypeSetConstants.standardSpacing
//		}
//
//		func newPage() -> CGFloat{
//			returnPosition = TypeSetConstants.header
//			beginPage = true
//			return onPage()
//		}
//
//		let qAndA = makeAttributedString(question: qa.question, answer: "")
//		let qAndAHeight = getAttributedStringHeight(qAndA) + TypeSetConstants.answerBoxHeight
//		return qAndAHeight + returnPosition < TypeSetConstants.pageHeight - TypeSetConstants.footer ? onPage() : newPage()
//	}
	
	func addImage(imageTop: CGFloat, image: UIImage, frontPageAdjust: CGFloat = 0.0) -> CGFloat {
		let maxHeight = TypeSetConstants.pageHeight
		let maxWidth = TypeSetConstants.pageWidth * 0.75
		let aspectWidth = maxWidth / image.size.width
		let aspectHeight = maxHeight / image.size.height
		let aspectRatio = min(aspectWidth, aspectHeight)
		let scaledWidth = image.size.width * aspectRatio
		let scaledHeight = image.size.height * aspectRatio
		let imageX = (TypeSetConstants.pageWidth - scaledWidth) / 2.0
		let imageRect = CGRect(
			x: imageX,
			y: imageTop+frontPageAdjust,
			width: scaledWidth,
			height: scaledHeight
		)
		image.draw(in: imageRect)
		blankPage = false
		return imageRect.origin.y + imageRect.size.height
	}
}

