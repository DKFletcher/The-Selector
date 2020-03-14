//
//  String.swift
//  WML
//
//  Created by Donald Fletcher on 27/02/2020.
//  Copyright © 2020 Donald Fletcher. All rights reserved.
//

import Foundation
extension String{
	mutating func removeFirstRegEx( regEx regularExprresion: NSRegularExpression){
		let string = self as NSString
		let matches = regularExprresion.matches(in: self, options: [], range: NSRange(location: 0, length: string.length))
		if matches.count != 0{
			if let range = Range(matches[0].range, in: self){
				self.removeSubrange(range)
			}
		}
	}

	func removePredicate(regEx regularExprresion: NSRegularExpression)->String{
		let string = self as NSString
		var predicateRemoved = String(self)
		let matches = regularExprresion.matches(in: self, options: [], range: NSRange(location: 0, length: string.length))
		if matches.count != 0{
			if let range = Range(matches[0].range, in: self){
				predicateRemoved.removeSubrange(range)
			}
		}
		return predicateRemoved
	}
//	mutating func insertSpaceAfterCarriageReturn() -> String{
//		let string = self as NSString
//		if let regularExpression = try? NSRegularExpression(pattern: "\\n"){
//			let matches = regularExpression.matches(in: self, options: [], range: NSRange(location: 0, length: string.length))
//			matches.forEach{ match in
//				if let range = Range(match.range, in: self){
//					self.replaceSubrange(range, with: " \n")
//				}
//			}
//		}
//		return self
//	}
}
