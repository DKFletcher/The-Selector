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
	
	var bookIndex : [IndexEntry]! = []
	
	var cards : [Card]!
	
	var renderer : UIGraphicsPDFRenderer {
		let pdfMetaData = [
			kCGPDFContextCreator: "Emotions Handbook",
			kCGPDFContextAuthor: "Alan McLean"
		]
		let format = UIGraphicsPDFRendererFormat()
		format.documentInfo = pdfMetaData as [String: Any]
		return UIGraphicsPDFRenderer(bounds: TypeSetConstants.pageRect, format: format)
	}
	
	func getIndex(book : [Card]){
		cards = book
		EmotionItems.Quadrant.allCases.forEach{ quadrant in
			book.filter{ $0.emotion.quadrant == quadrant }.forEach{ emotion in
				bookIndex.append(
					IndexEntry(
						destination: emotion.emotion.index.emotion.rawValue,
						emotion: emotion.emotion.index))
			}
		}
		bookIndex.sort {
			($0.emotion.quadrant.rawValue,  $0.emotion.position) <
				($1.emotion.quadrant.rawValue, $1.emotion.position)
		}
	}

	
	func handbook(from cards: [Card]) -> Data {
		getIndex(book: cards)
		let pdfMetaData = [
			kCGPDFContextCreator: "Emotions Handbook",
			kCGPDFContextAuthor: "Alan McLean"
		]
		let format = UIGraphicsPDFRendererFormat()
		format.documentInfo = pdfMetaData as [String: Any]
		let renderer = UIGraphicsPDFRenderer(bounds: TypeSetConstants.pageRect, format: format)
		
		let data = renderer.pdfData { (context) in
			drawingPDF = context
			dustCover()
			documentIndex()
			introduction()
			chapter(for: bookIndex.filter{$0.emotion.quadrant == .stretchingMe})
			chapter(for: bookIndex.filter{$0.emotion.quadrant == .connectingMe})
			chapter(for: bookIndex.filter{$0.emotion.quadrant == .protectingMe})
			chapter(for: bookIndex.filter{$0.emotion.quadrant == .meFirst})
		}
		return data
	}
	
	func chapter(for indexEntry: [IndexEntry]){
		
		if let quadrantName = indexEntry[0].emotion.getPDFName(for: indexEntry[0].emotion.quadrant.rawValue){
			createPage(destination: indexEntry[0].emotion.quadrant.rawValue, for: quadrantName)
		}
		var oldZone = ""
		for page in indexEntry{
			if page.emotion.zone.rawValue != oldZone{
				oldZone = page.emotion.zone.rawValue
				if let emotionName = page.emotion.getPDFName(for: page.emotion.zone.rawValue){
					createPage(destination: page.emotion.zone.rawValue, for: emotionName)
				}
			}
			if let emotionName = page.emotion.getPDFName(for: page.emotion.emotion.rawValue){
				createPage(destination: page.emotion.emotion.rawValue, for: emotionName)
				cards.forEach{ card in
					if card.emotion.index.emotion.rawValue == page.emotion.emotion.rawValue {
						if card.emotion.custom{
							customImage(for: card, using: card.name)
						}
					}
				}
			}
		}
	}
	
	func dustCover(){
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
	
	func introduction(){
		if let url = Bundle.main.url(forResource: "Introduction", withExtension: "pdf"){
			if let document = CGPDFDocument(url as CFURL) {
				for pdfPage in 1...10{
					if let page = document.page(at: pdfPage){
						beginPage = true
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
	}
	
	func createPage(destination indexString: String, for quad: String){
		if let url = Bundle.main.url(forResource: quad, withExtension: "pdf"){
			if let document = CGPDFDocument(url as CFURL) {
				if let page = document.page(at: 1){
					destination = indexString
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
	
	func customImage(for card : Card, using title: String){
		beginPage = true
		let attributes = getAttributes(fontSizeDelta: 10.0)
		let attributedString = NSAttributedString(string: title, attributes: attributes)
		let stringSize = getAttributedStringSize(attributedString)
		let stringRect = CGRect(origin: CGPoint(x: TypeSetConstants.margin, y: TypeSetConstants.header), size: stringSize)
		attributedString.draw(in: stringRect)
		_=addImage(imageTop: TypeSetConstants.header+stringRect.height+20.0, image: imageServer.get(image: card))
		
	}
	
	func documentIndex(){
		beginPage = true
		let inset = CGFloat(40.0)
		let boxHeightRatio = CGFloat(0.75)//This sets the hight of each box
		let distanceOfIndexFromTop = CGFloat(100.0)
		let yIncrement = (boxHeightRatio*TypeSetConstants.pageHeight-2*inset) / 2.0 - inset
		let xIncrement = (TypeSetConstants.pageWidth-2*inset) / 2.0 - inset
		var x = TypeSetConstants.pageRect.insetBy(dx: inset/2, dy: inset/2).minX+inset/2
		var y = TypeSetConstants.pageRect.insetBy(dx: inset/2, dy: inset/2).minY+inset/2 + distanceOfIndexFromTop
		let boxContext = drawingPDF.cgContext
		let textWidthInsetForBox = inset+CGFloat(-15.0)
		let textHeightInsetForBox = inset+CGFloat(-55.0)
		
		let stretchingMeCGRect = CGRect(x: x,y: y,width: TypeSetConstants.pageWidth / 2.0,height: boxHeightRatio*TypeSetConstants.pageHeight / 2.0)
		let stretchingMeIndexEntry = bookIndex.filter{$0.emotion.quadrant == .stretchingMe}
		documentIndex(
			indexEntry: stretchingMeIndexEntry,
			topRightCorner: CGPoint(x: stretchingMeCGRect.minX+textWidthInsetForBox, y: stretchingMeCGRect.minY+textHeightInsetForBox),
			destinationString: stretchingMeIndexEntry[0].destination)
		drawOutlineBoxForIndex(for: stretchingMeCGRect, in : boxContext, inset: inset)

		x += xIncrement
		let connectingMeCGRect = CGRect(x: x,y: y,width: TypeSetConstants.pageWidth / 2.0,height: boxHeightRatio*TypeSetConstants.pageHeight / 2.0)
		let connectingMeIndexEntry = bookIndex.filter{$0.emotion.quadrant == .connectingMe}
		documentIndex(
			indexEntry: connectingMeIndexEntry,
			topRightCorner: CGPoint(x: connectingMeCGRect.minX+textWidthInsetForBox, y: connectingMeCGRect.minY+textHeightInsetForBox),
			destinationString: connectingMeIndexEntry[0].destination)
		drawOutlineBoxForIndex(for: connectingMeCGRect, in : boxContext, inset: inset)

		y += yIncrement
		x=TypeSetConstants.pageRect.insetBy(dx: inset/2, dy: inset/2).minX+inset/2
		let meFirstCGRect = CGRect(x: x,y: y,width: TypeSetConstants.pageWidth / 2.0,height: boxHeightRatio*TypeSetConstants.pageHeight / 2.0)
		let meFirstIndexEntry = bookIndex.filter{$0.emotion.quadrant == .meFirst}
		documentIndex(
			indexEntry: meFirstIndexEntry,
			topRightCorner: CGPoint(x: meFirstCGRect.minX+textWidthInsetForBox, y: meFirstCGRect.minY+textHeightInsetForBox),
			destinationString: meFirstIndexEntry[0].destination)
		drawOutlineBoxForIndex(for: meFirstCGRect, in : boxContext, inset: inset)

		x += xIncrement
		let protectingMeCGRect = CGRect(x: x,y: y,width: TypeSetConstants.pageWidth / 2.0,height: boxHeightRatio*TypeSetConstants.pageHeight / 2.0)
		let protectingMeIndexEntry = bookIndex.filter{$0.emotion.quadrant == .protectingMe}
		documentIndex(
			indexEntry: protectingMeIndexEntry,
			topRightCorner: CGPoint(x: protectingMeCGRect.minX+textWidthInsetForBox, y: protectingMeCGRect.minY+textHeightInsetForBox),
			destinationString: protectingMeIndexEntry[0].destination)
		drawOutlineBoxForIndex(for: protectingMeCGRect, in : boxContext, inset: inset)
	}
	
	func documentIndex(indexEntry : [IndexEntry], topRightCorner : CGPoint, destinationString : String){
		let textPositionInQuad = CGPoint(x: topRightCorner.x+20.0, y: topRightCorner.y+60.0)
		var y_offset = CGFloat(0.0)
		let zone_offset = CGFloat(0.0)
		let emotion_offset = zone_offset+CGFloat(0.0)
		let quadrantFontSizeDelta = CGFloat(0.0)
		let zoneFontSizeDelta = CGFloat(-7.0)
		let emotionFontSizeDelta = CGFloat(-3.0)
		y_offset += indexItem(
			fontSizeDelta: quadrantFontSizeDelta,
			text: indexEntry[0].emotion.quadrant.rawValue,
			at: textPositionInQuad,
			additional: "Quadrant")
		var oldZone : Index.Zone!
		
		for page in indexEntry{
			if page.emotion.zone != oldZone{
				y_offset += indexItem(
					fontSizeDelta: zoneFontSizeDelta,
					text: page.emotion.zone.rawValue,
					at: textPositionInQuad.delta(dx: zone_offset, dy: y_offset),
					additional: "Zone")
				oldZone = page.emotion.zone
			}
			y_offset += indexItem(
				fontSizeDelta: emotionFontSizeDelta,
				text: page.emotion.emotion.rawValue,
				at: textPositionInQuad.delta(dx: emotion_offset, dy: y_offset),
				additional: "")
		}
	}
	
	func indexItem( fontSizeDelta delta: CGFloat, text indexText: String, at cgPoint : CGPoint, additional text: String)->CGFloat{
		let attributes = getAttributes(fontSizeDelta: delta)
		let attributedString = NSAttributedString(string: "\(indexText) \(text)",attributes: attributes)
		let stringSize = getAttributedStringSize(attributedString)
		let stringRect = CGRect(origin: cgPoint, size: stringSize)
		attributedString.draw(in: stringRect)
		let linkArea = stringRect.applying(drawingPDF.cgContext.userSpaceToDeviceSpaceTransform)
		drawingPDF.setDestinationWithName(indexText, for: linkArea)
		return stringRect.height
	}
	
	func getAttributes(fontSizeDelta delta : CGFloat)->[NSAttributedString.Key: Any]{
		let quadrantFont = UIFont.systemFont(
			ofSize: TypeSetConstants.bodyFontSize+delta,
			weight: .regular)
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .left
		paragraphStyle.lineBreakMode = .byWordWrapping
		return [
			NSAttributedString.Key.paragraphStyle: paragraphStyle,
			NSAttributedString.Key.font: quadrantFont,
			NSAttributedString.Key.foregroundColor: UIColor.black]
	}
	
	func getAttributedStringSize(_ nsAttributedString: NSAttributedString ) ->CGSize{
		let qAndATest = nsAttributedString.boundingRect(
			with: CGSize(
				width: CGFloat.greatestFiniteMagnitude,
				height: CGFloat.greatestFiniteMagnitude
			),
			options: [.usesLineFragmentOrigin, .usesFontLeading],
			context: nil)
		
		return CGSize(width: ceil(qAndATest.width), height: ceil(qAndATest.height))
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

extension CGPoint{
	func delta(dx deltaX : CGFloat, dy deltaY: CGFloat)->CGPoint{
		return CGPoint(x: self.x + deltaX, y: self.y + deltaY)
	}
}
