//
//  QuestionAnswer.swift
//  WML
//
//  Created by Donald Fletcher on 03/02/2020.
//  Copyright © 2020 Donald Fletcher. All rights reserved.
//

import Foundation


enum Phase : Int, CaseIterable{
	case first, second, third
}

enum BoxID: Int, CaseIterable{
	case topLeft, topRight, middleLeft, middleRight, bottomLeft, bottomRight, scraps
}

class QuestionAnswer : NSObject {
	
	var question : String = ""
	
	var answer : String = ""
	
	var atempted : Bool = false
	
	init (question q : String, answer a : String){
		self.question = q
		self.answer = a
	}
}


class Worksheet {
	var topLeft : [QuestionAnswer] = []
	var topRight : [QuestionAnswer] = []
	var middleLeft : [QuestionAnswer] = []
	var middleRight : [QuestionAnswer] = []
	var bottomLeft : [QuestionAnswer] = []
	var bottomRight : [QuestionAnswer] = []
	var scraps : [QuestionAnswer] = []

//	var allAtempted : Bool {
//		return topLeft?.allSatisfy { if let {$0.atempted} else true }
//			&& topRight.allSatisfy { $0.atempted }
//			&& middleLeft.allSatisfy { $0.atempted }
//			&& middleRight.allSatisfy { $0.atempted }
//			&& bottomLeft.allSatisfy { $0.atempted }
//			&& bottomRight.allSatisfy { $0.atempted }
//	}

		var isComplete : Bool {
			return topLeft.allSatisfy { $0.atempted }
				&& topRight.allSatisfy { $0.atempted }
				&& middleLeft.allSatisfy { $0.atempted }
				&& middleRight.allSatisfy { $0.atempted }
				&& bottomLeft.allSatisfy { $0.atempted }
				&& bottomRight.allSatisfy { $0.atempted }
		}
	
	required init(
		topLeft row1L: [QuestionAnswer],
		topRight row1R: [QuestionAnswer],
		middleLeft row2L: [QuestionAnswer],
		middleRight row2R: [QuestionAnswer],
		bottomLeft row3L : [QuestionAnswer],
		bottomRight row3R : [QuestionAnswer],
		scraps forLater : [QuestionAnswer] = [])
	{
		self.topLeft = row1L
		self.middleLeft = row2L
		self.bottomLeft = row3L
		self.topRight = row1R
		self.middleRight = row2R
		self.bottomRight = row3R
		self.scraps = forLater
	}
	
	func allSections() -> [[QuestionAnswer]]{
		return [topLeft,topRight,middleLeft,middleRight,bottomLeft,bottomRight,scraps]
	}
	
	func setSections(from file : [QA]){
	}
	
	func sections() -> [[QuestionAnswer]]{
		return [topLeft,topRight,middleLeft,middleRight,bottomLeft,bottomRight]
	}
	
	lazy var numberOfQuestions : Int = {
		return topLeft.count + topRight.count + middleRight.count + middleLeft.count + bottomRight.count + bottomLeft.count
	}()
}

extension Worksheet {
	func itemList(for boxID : BoxID) -> [QuestionAnswer]{
		switch boxID{
		case .topLeft: 	return topLeft
		case .topRight: return topRight
		case .middleLeft: return middleLeft
		case .middleRight: return middleRight
		case .bottomLeft: return bottomLeft
		case .bottomRight: return bottomRight
		case .scraps: return scraps
		}
	}
	
	func addItem(_ item : QuestionAnswer, for boxID: BoxID, at index : Int = -1){
		switch boxID{
		case .topLeft:
			if index < 0 {
				topLeft.append(item)
			} else {
				topLeft.insert(item, at: index)
			}
		case .topRight:
			if index < 0 {
				topRight.append(item)
			}else {
				topRight.insert(item, at: index)
			}
		case .middleLeft:
			if index < 0 {
				middleLeft.append(item)
			}else {
				middleLeft.insert(item, at: index)
			}
		case .middleRight:
			if index < 0 {
				middleRight.append(item)
			}else {
				middleRight.insert(item, at: index)
			}
		case .bottomLeft:
			if index < 0 {
				bottomLeft.append(item)
			}else {
				bottomLeft.insert(item, at: index)
			}
		case .bottomRight:
			if index < 0 {
				bottomRight.append(item)
			}else {
				bottomRight.insert(item, at: index)
			}
		case .scraps:
			if index < 0 {
				scraps.append(item)
			}else {
				scraps.insert(item, at: index)
			}
		}
	}
	
	func newItem()-> QuestionAnswer{
		let item = QuestionAnswer(question: "", answer: "")
		topLeft.append(item)
		return item
	}
	
	func move(
		item : QuestionAnswer,
		from sourceBox: BoxID,
		at sourceIndex: Int,
		to destinitionBox: BoxID,
		at destinationIndex : Int)
	{
		remove(item, from: sourceBox, at: sourceIndex)
		addItem(item, for: destinitionBox, at: destinationIndex)
	}
	
	func remove(
		_ item: QuestionAnswer,
		from  boxID: BoxID,
		at index: Int)
	{
		switch boxID{
		case .topLeft: topLeft.remove(at: index)
		case .topRight: topRight.remove(at : index)
		case .middleLeft: middleLeft.remove(at: index)
		case .middleRight: middleRight.remove(at: index)
		case .bottomLeft: bottomLeft.remove(at: index)
		case .bottomRight: bottomRight.remove(at: index)
		case .scraps: scraps.remove(at: index)
		}
	}
}

extension Worksheet : Hashable{
	static func == (lhs: Worksheet, rhs: Worksheet) -> Bool {
		return lhs.topLeft == rhs.topLeft && lhs.topRight == rhs.topRight && lhs.middleLeft == rhs.middleLeft && lhs.middleRight == rhs.middleRight && lhs.bottomLeft == rhs.bottomLeft && lhs.bottomRight == rhs.bottomRight && lhs.scraps == rhs.scraps
	}
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(topLeft)
		hasher.combine(topRight)
		hasher.combine(middleLeft)
		hasher.combine(middleRight)
		hasher.combine(bottomLeft)
		hasher.combine(bottomRight)
		hasher.combine(scraps)
	}
}
