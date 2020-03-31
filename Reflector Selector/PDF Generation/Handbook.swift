//
//  File.swift
//  Reflector Selector
//
//  Created by Donald Fletcher on 31/03/2020.
//  Copyright © 2020 whatmotivateslearning. All rights reserved.
//

import UIKit
import PDFKit

class Handbook : PDFSuperView{
	
	override init(learner name: String?) {
		super.init(learner: name)
	}
	
	
	func handbook(from book: [Card]) -> Data {
		let pdfMetaData = [
			kCGPDFContextCreator: "Emotions Handbook",
			kCGPDFContextAuthor: "Alan McLean"
		]
		let format = UIGraphicsPDFRendererFormat()
		format.documentInfo = pdfMetaData as [String: Any]
		let renderer = UIGraphicsPDFRenderer(bounds: TypeSetConstants.pageRect, format: format)
		let data = renderer.pdfData { (context) in
			drawingPDF = context
			createFrontPage()
			
			
			EmotionItems.Quadrant.allCases.forEach{ quadrant in
				var indexQuadrant = true
//				var indexZone = true
				book.filter{ $0.emotion.quadrant == quadrant }.forEach{ emotion in
					if indexQuadrant{
						createQuad(for: quadrant.rawValue, in : emotion.emotion.index)
						bookIndex.append(IndexEntry(destination: emotion.emotion.index.quadrant.rawValue, emotion: emotion.emotion.index))
						indexQuadrant = false
					}
					createNote(for: emotion, in : emotion.emotion.index)
					bookIndex.append(IndexEntry(destination: emotion.emotion.index.emotion.rawValue, emotion: emotion.emotion.index))
					if emotion.emotion.custom{
//						createWork(for: emotion)
					}
				}
			}
			printIndex()
		}
		return data
	}
	
	
	func createQuad(for quad: String, in index: Index){
		if let url = Bundle.main.url(forResource: quad, withExtension: "pdf"){
			if let document = CGPDFDocument(url as CFURL) {
				if let page = document.page(at: 1){
					destination = index.quadrant.rawValue
					let context = drawingPDF.cgContext
					context.scaleBy(x: -1.0, y: 1.0)
					context.translateBy(x: -TypeSetConstants.pageWidth, y: 0.0)
					context.rotate(by: -CGFloat.pi)
					context.translateBy(x: -TypeSetConstants.pageWidth, y: -TypeSetConstants.pageHeight)
					context.drawPDFPage(page)
				}
			}
		}
	}
	
	func createNote(for emotion: Card, in index: Index){
		if let url = Bundle.main.url(forResource: emotion.name, withExtension: "pdf"){
			if let document = CGPDFDocument(url as CFURL) {
				if let page = document.page(at: 1){
					destination = index.emotion.rawValue
					let context = drawingPDF.cgContext
					context.scaleBy(x: -1.0, y: 1.0)
					context.translateBy(x: -TypeSetConstants.pageWidth, y: 0.0)
					context.rotate(by: -CGFloat.pi)
					context.translateBy(x: -TypeSetConstants.pageWidth, y: -TypeSetConstants.pageHeight)
					context.drawPDFPage(page)
				}
			}
		}
	}

	func printIndex(){
		let indexEntry = bookIndex.sorted {
			($0.emotion.quadrant.rawValue,  $0.emotion.position) <
				($1.emotion.quadrant.rawValue, $1.emotion.position)
		}
		beginPage = true
		let inset = CGFloat(10.0)
		let yIncrement = (TypeSetConstants.pageHeight-2*inset) / 2.0 - inset
		let xIncrement = (TypeSetConstants.pageWidth-2*inset) / 2.0 - inset
		var x = TypeSetConstants.pageRect.insetBy(dx: inset/2, dy: inset/2).minX+inset/2
		var y = TypeSetConstants.pageRect.insetBy(dx: inset/2, dy: inset/2).minY+inset/2
		let boxContext = drawingPDF.cgContext

		let stretchingMeCGRect = CGRect(x: x,y: y,width: TypeSetConstants.pageWidth / 2.0,height: TypeSetConstants.pageHeight / 2.0)
		let stretchingMeIndexEntry = indexEntry.filter{$0.emotion.quadrant == .stretchingMe}
		drawAttributedString(indexEntry: stretchingMeIndexEntry, startPoint: CGPoint(x: stretchingMeCGRect.minX, y: stretchingMeCGRect.minY), destinationString: stretchingMeIndexEntry[0].destination)
		drawOutlineBoxForIndex(for: stretchingMeCGRect, in : boxContext, inset: inset)

		x += xIncrement
		let connectingMeCGRect = CGRect(x: x,y: y,width: TypeSetConstants.pageWidth / 2.0,height: TypeSetConstants.pageHeight / 2.0)
		let connectingMeIndexEntry = indexEntry.filter{$0.emotion.quadrant == .connectingMe}
		drawAttributedString(indexEntry: connectingMeIndexEntry, startPoint: CGPoint(x: connectingMeCGRect.minX, y: connectingMeCGRect.minY), destinationString: connectingMeIndexEntry[0].destination)
		drawOutlineBoxForIndex(for: connectingMeCGRect, in : boxContext, inset: inset)

		y+=yIncrement
		x=TypeSetConstants.pageRect.insetBy(dx: inset/2, dy: inset/2).minX+inset/2
		let meFirstCGRect = CGRect(x: x,y: y,width: TypeSetConstants.pageWidth / 2.0,height: TypeSetConstants.pageHeight / 2.0)
		let meFirstIndexEntry = indexEntry.filter{$0.emotion.quadrant == .meFirst}
		drawAttributedString(indexEntry: meFirstIndexEntry, startPoint: CGPoint(x: meFirstCGRect.minX, y: meFirstCGRect.minY), destinationString: connectingMeIndexEntry[0].destination)
		drawOutlineBoxForIndex(for: meFirstCGRect, in : boxContext, inset: inset)

		x += xIncrement
		let protectingMeCGRect = CGRect(x: x,y: y,width: TypeSetConstants.pageWidth / 2.0,height: TypeSetConstants.pageHeight / 2.0)
		let protectingMeIndexEntry = indexEntry.filter{$0.emotion.quadrant == .protectingMe}
		drawAttributedString(indexEntry: protectingMeIndexEntry, startPoint: CGPoint(x: protectingMeCGRect.minX, y: protectingMeCGRect.minY), destinationString: protectingMeIndexEntry[0].destination)
		drawOutlineBoxForIndex(for: protectingMeCGRect, in : boxContext, inset: inset)
	}
	
	func makeIndex(index text : NSMutableAttributedString, at rect: CGRect){
		let bodyFont = UIFont(name: "Chalkduster", size: TypeSetConstants.bodyFontSize)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .left
		paragraphStyle.lineBreakMode = .byWordWrapping
		let bodyAttributes: [NSAttributedString.Key: Any] = [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: bodyFont!,
			NSAttributedString.Key.foregroundColor: UIColor.black]
	}
	
	func drawAttributedString(indexEntry : [IndexEntry], startPoint : CGPoint, destinationString : String){
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
		
		
		var oldQuadrant : Index.Quadrant!
		var oldZone : Index.Zone!
		let quadrantIndexNSAttributedString = NSMutableAttributedString(string: "Quadrant: \(indexEntry[0].emotion.quadrant.rawValue)", attributes: boldAttributes)
		quadrantIndexNSAttributedString.draw(at: startPoint)
		drawingPDF.setDestinationWithName(destinationString, for: CGRect(origin: startPoint, size: quadrantIndexNSAttributedString.size()))
		//		for page in indexEntry{
		//			if page.emotion.zone != oldZone{
		//				print("   Zone: \(page.emotion.zone)")
		//				oldZone = page.emotion.zone
		//			}
		//			print("      Emotion: \(page.emotion.emotion)")
		//		}
	}
	
	
	
	
	
	
	
	
	
	
	
	
	func drawOutlineBoxForIndex(for rect : CGRect, in context : CGContext, inset by : CGFloat){
		//		context.saveGState()
		context.setFillColor(UIColor.blue.cgColor)
		context.setLineWidth(TypeSetConstants.answerBoxLineWidth)
		context.setStrokeColor(UIColor.black.cgColor)
		context.addRect(rect.insetBy(dx: by, dy: by))
		context.drawPath(using: .stroke)
		//		context.restoreGState()
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	func createFrontPage(){
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
		return textRect.origin.y + ceil(textRect.size.height)
	}
	
}
