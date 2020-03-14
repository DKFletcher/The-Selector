//
//  UIViewController.swift
//  WML
//
//  Created by Donald Fletcher on 19/12/2019.
//  Copyright © 2019 Donald Fletcher. All rights reserved.
//

import UIKit

extension UIViewController {
	func topMostController() -> UIViewController {
		var topController: UIViewController = UIApplication.shared.keyWindow!.rootViewController!
		while (topController.presentedViewController != nil) {
			topController = topController.presentedViewController!
		}
		return topController
	}
}
extension UIViewController {
	func centeredAttributedString(_ string : String) -> NSAttributedString{
		let font : UIFont = getFont()
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .center
		return NSAttributedString(string: string, attributes : [.paragraphStyle: paragraphStyle, .font: font])
	}
	
	func leftAttributedString(_ string : String) -> NSAttributedString{
		let font : UIFont = getFont()
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .left
		return NSAttributedString(string: string, attributes : [.paragraphStyle: paragraphStyle, .font: font])
	}
	
	func rightAttributedString(_ string : String) -> NSAttributedString{
		let font : UIFont = getFont()
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .right
		return NSAttributedString(string: string, attributes : [.paragraphStyle: paragraphStyle, .font: font])
	}
	
	func getFont() -> UIFont{
		var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
		font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
		return font
	}
	struct SizeRatio {
		static let fontSizeToBoundsWidth: CGFloat = 0.064
		static let labelRatioHeightFontSize: CGFloat = 1.8
		static let boxOffset: CGFloat = 5
		static let PDFPageWidth : CGFloat = 600.0
		static let PDFPageHeight : CGFloat = 900.0

		static let PDFPageSize : CGSize = CGSize(
			width: PDFPageWidth,
			height: PDFPageHeight)
		
	}
	var fontSize: CGFloat {
		return 16//bounds.size.height * SizeRatio.fontSizeToBoundsWidth
	}
	
	var questionHeight: CGFloat {
		return fontSize * SizeRatio.labelRatioHeightFontSize
	}
	
	func offset(from box : CGRect) -> CGRect{
		return CGRect(x: CGFloat(box.minX) + SizeRatio.boxOffset,
									y: CGFloat(box.minY) + SizeRatio.boxOffset,
									width: box.width - SizeRatio.boxOffset * 2,
									height: box.height - SizeRatio.boxOffset * 2)
	}
}
