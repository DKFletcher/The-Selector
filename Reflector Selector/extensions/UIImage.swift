//
//  UIImage.swift
//  Reflector Selector
//
//  Created by Donald Fletcher on 09/03/2020.
//  Copyright © 2020 whatmotivateslearning. All rights reserved.
//

import UIKit

extension UIImage {
	func resized(withPercentage percentage: CGFloat, isOpaque: Bool = true) -> UIImage? {
		let canvas = CGSize(width: size.width * percentage, height: size.height * percentage)
		let format = imageRendererFormat
		format.opaque = isOpaque
		return UIGraphicsImageRenderer(size: canvas, format: format).image {
			_ in draw(in: CGRect(origin: .zero, size: canvas))
		}
	}
	func resized(toWidth width: CGFloat, isOpaque: Bool = true) -> UIImage? {
		let canvas = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
		let format = imageRendererFormat
		format.opaque = isOpaque
		return UIGraphicsImageRenderer(size: canvas, format: format).image {
			_ in draw(in: CGRect(origin: .zero, size: canvas))
		}
	}
}
