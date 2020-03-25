//
//  HeartHandbookPDF.swift
//  Reflector Selector
//
//  Created by Donald Fletcher on 11/03/2020.
//  Copyright © 2020 whatmotivateslearning. All rights reserved.
//

import UIKit
import PDFKit

class HeartHandbook : PDFSuperView{
	
	override init(learner name: String?) {
		super.init(learner: name)
	}
	
	func merge(pdfs: [Data]) -> Data {
		let out = NSMutableData()
		UIGraphicsBeginPDFContextToData(out, .zero, nil)
		guard let context = UIGraphicsGetCurrentContext() else {
			return out as Data
		}
		for pdf in pdfs {
			guard let dataProvider = CGDataProvider(data: pdf as CFData), let document = CGPDFDocument(dataProvider) else { continue }
			for pageNumber in 1...document.numberOfPages {
				guard let page = document.page(at: pageNumber) else { continue }
				var mediaBox = page.getBoxRect(.mediaBox)
				context.beginPage(mediaBox: &mediaBox)
				context.drawPDFPage(page)
				context.endPage()
			}
		}
		context.closePDF()
		UIGraphicsEndPDFContext()
		return out as Data
	}
	
	func handbook(from book: [Card]) -> Data {
		var pdfData : [Data] = []
		pdfData.append(createFrontPage())
		EmotionItems.Quadrant.allCases.forEach{ quadrant in
			pdfData.append(createQuad(for: quadrant.rawValue))
			book.filter{ $0.emotion.quadrant == quadrant }.forEach{ emotion in
				pdfData.append(createNote(for: emotion))
				if emotion.emotion.custom{
					pdfData.append(createWork(for: emotion))
				}
			}
		}
		return merge(pdfs: pdfData)
	}

	func infoSheet(for card: Card) -> Data {
		var pdfData : [Data] = []
		pdfData.append(createQuad(for: card.emotion.quadrant.rawValue))
			pdfData.append(createNote(for: card))//emotion))
			if card.emotion.custom{
				pdfData.append(createWork(for: card))
			}
		return merge(pdfs: pdfData)
	}

	
	func createFrontPage() ->Data{
		let pdfMetaData = [
			kCGPDFContextCreator: "Reflector Selector Log Book",
			kCGPDFContextAuthor: "MADFullStack.com"
		]
		let format = UIGraphicsPDFRendererFormat()
		format.documentInfo = pdfMetaData as [String: Any]
		let renderer = UIGraphicsPDFRenderer(bounds: TypeSetConstants.pageRect, format: format)
		let data = renderer.pdfData { (context) in
			drawingPDF = context
			blankPage = false
			beginPage = true
			let imageBottom = addImage(
				imageTop: TypeSetConstants.header,
				image: UIImage(named: "Joy_3_1_750")!,
				frontPageAdjust: TypeSetConstants.pageHeight/2 - 300.0
				) + TypeSetConstants.standardSpacing*2
			if let name = learnerName{
				_=addAddvice(tag: "Reflector Selector Handbook\n"+name, position: imageBottom)
			}
		}
		return data
	}

	func createQuad(for quad: String) -> Data {
		let out = NSMutableData()
		UIGraphicsBeginPDFContextToData(out, .zero, nil)
		guard let context = UIGraphicsGetCurrentContext() else {
			return out as Data
		}
		guard let url = Bundle.main.url(forResource: quad, withExtension: "pdf"),
			let document = CGPDFDocument(url as CFURL) else {
				print("PDFViewController, pdf url definition fail for \(quad)")
				return out as Data
		}
		if let page = document.page(at: 1){
			var mediaBox = page.getBoxRect(.mediaBox)
			context.beginPage(mediaBox: &mediaBox)
			context.drawPDFPage(page)
			context.endPage()
		}
		context.closePDF()
		UIGraphicsEndPDFContext()
		return out as Data
	}

	func createNote(for emotion: Card) -> Data {
		let out = NSMutableData()
		UIGraphicsBeginPDFContextToData(out, .zero, nil)
		guard let context = UIGraphicsGetCurrentContext() else {
			return out as Data
		}
		guard let url = Bundle.main.url(forResource: emotion.name, withExtension: "pdf"),
			let document = CGPDFDocument(url as CFURL) else {
				print("PDFViewController, pdf url definition fail for \(emotion.name)")
				return out as Data
		}
		if let page = document.page(at: 1){
			var mediaBox = page.getBoxRect(.mediaBox)
			context.beginPage(mediaBox: &mediaBox)
			context.drawPDFPage(page)
			context.endPage()
		}
		context.closePDF()
		UIGraphicsEndPDFContext()
		return out as Data
	}

	func createWork(for emotion : Card) -> Data {
		print("createWork")
		let renderer = UIGraphicsPDFRenderer(bounds: TypeSetConstants.pageRect)
		let data = renderer.pdfData { (context) in
			drawingPDF = context
			beginPage = true
			blankPage = false
			learnerName = emotion.name.uppercased()
			pagePosition = addTitle(card: emotion)
			pagePosition = addImage(
				imageTop: pagePosition + TypeSetConstants.standardSpacing,
				image: imageServer.get(image: emotion)
			)
		}
		return data
	}

	private func addAddvice(tag line : String, position top : CGFloat) -> CGFloat{
		let tagLineFont = UIFont.systemFont(ofSize: TypeSetConstants.tagLineFontSize, weight: .medium)
		
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .center
		paragraphStyle.lineBreakMode = .byWordWrapping
		let attributes: [NSAttributedString.Key: Any] = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: tagLineFont,
			NSAttributedString.Key.foregroundColor: UIColor.darkGray]
		
		let attributed = NSAttributedString(string: line, attributes: attributes)
		
		let rect = attributed.boundingRect(
			with: CGSize(
				width: TypeSetConstants.pageWidth,
				height: CGFloat.greatestFiniteMagnitude
			),
			options: [.usesLineFragmentOrigin, .usesFontLeading],
			context: nil
		)
		let textRect = CGRect(
			x: TypeSetConstants.margin,
			y: top,
			width: TypeSetConstants.pageWidth - TypeSetConstants.margin*2,
			height: ceil(rect.height)
		)
		attributed.draw(in: textRect)
		blankPage = false
		return textRect.origin.y + ceil(textRect.size.height)
	}

	
	func addTitle() -> CGFloat {
		let titleFont = UIFont.systemFont(ofSize: 50.0, weight: .bold)
		let titleAttributes: [NSAttributedString.Key: Any] = [
			NSAttributedString.Key.font: titleFont,
			NSAttributedString.Key.foregroundColor: UIColor.darkGray]
		let stringToBeTitle = learnerName ?? ""
		let attributedTitle = NSAttributedString(string: stringToBeTitle, attributes: titleAttributes)
		let titleStringSize = attributedTitle.size()
		let titleStringRect = CGRect(x: (TypeSetConstants.pageWidth - titleStringSize.width) / 2.0,
																 y: TypeSetConstants.header, width: titleStringSize.width,
																 height: titleStringSize.height)
		attributedTitle.draw(in: titleStringRect)
		blankPage = false
		return titleStringRect.origin.y + titleStringRect.size.height
	}

	func addTitle(card : Card) -> CGFloat {
		let titleFont = UIFont(name: "Chalkduster", size: TypeSetConstants.tagLineFontSize)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .center
		paragraphStyle.lineBreakMode = .byWordWrapping
		let titleAttributes: [NSAttributedString.Key: Any] = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: titleFont!,
			NSAttributedString.Key.foregroundColor: UIColor.darkGray]
		let stringToBeTitle = card.name
		let attributedTitle = NSAttributedString(string: stringToBeTitle, attributes: titleAttributes)
		let titleStringSize = attributedTitle.size()
		let titleStringRect = CGRect(x: (TypeSetConstants.pageWidth - titleStringSize.width) / 2.0,
																 y: TypeSetConstants.header, width: titleStringSize.width,
																 height: titleStringSize.height)
		attributedTitle.draw(in: titleStringRect)
		blankPage = false
		return titleStringRect.origin.y + titleStringRect.size.height
	}
}
