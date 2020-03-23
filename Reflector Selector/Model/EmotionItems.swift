//
//  Emotions.swift
//  WML
//
//  Created by Donald Fletcher on 22/01/2020.
//  Copyright © 2020 Donald Fletcher. All rights reserved.
//

import Foundation
import UIKit

class EmotionItem : NSObject{
	var text : String
	var checked : Bool
	required init (text itemText : String, isReflector isChecked : Bool){
		text = itemText
		checked = isChecked
	}
	func toggleChecked(){
		checked = !checked
	}
}


class EmotionItems{
	var custom : Bool = false
	
	enum Quadrant: String, CaseIterable{
		case stretchingMe, connectingMe, protectingMe, meFirst
	}
	
	enum Psychology: Int, CaseIterable{
		case feelings, situations, behaviours, solutions
	}
	
	enum Phase : Int, CaseIterable, Encodable, Decodable{
		case first, second, third
	}
	
	let quadrant : Quadrant
	
	private var feelingsItems : [EmotionItem] = []
	private var motivesItems : [EmotionItem] = []
	private var behavioursItems : [EmotionItem] = []
	private var solutionsItems : [EmotionItem] = []
	private var ringPosition : Int = 0
	var feelings : [EmotionItem]{
		return feelingsItems
	}
	var motives : [EmotionItem]{
		return motivesItems
	}
	var behaviours : [EmotionItem]{
		return behavioursItems
	}
	var solutions : [EmotionItem]{
		return solutionsItems
	}
	var name : String
	var phase : Phase = Phase.third
//	var image : UIImage
	var qanda : Worksheet!
	
	required init (called byName : String,
								 feels like : [String],
								 motive  around : [String],
								 behaviour action : [String],
								 solution fix : [String],
								 ringID position : Int = 0,
								 stage age : Phase = Phase.third,
								 ring quadrant : Quadrant,
								 worksheet qanda : Worksheet){
//		self.image = UIImage(named: byName)! 
		self.name = byName
		self.ringPosition = position
		self.phase = age
		self.qanda = qanda
		self.quadrant = quadrant
		like.forEach{feelingsItems.append(EmotionItem(text: $0, isReflector: false))}
		around.forEach{motivesItems.append(EmotionItem(text: $0, isReflector: false))}
		action.forEach{behavioursItems.append(EmotionItem(text: $0, isReflector: false))}
		fix.forEach{solutionsItems.append(EmotionItem(text: $0, isReflector: false))}
	}
	
	func itemList(for psychology : Psychology) -> [EmotionItem]{
		switch psychology{
		case .feelings: 	return feelingsItems
		case .situations: return motivesItems
		case .behaviours: return behavioursItems
		case .solutions: return solutionsItems
		}
	}
	
	func relfelctorSelector(item : EmotionItem){
		for emotionItem in feelingsItems{
			emotionItem.checked = false
		}
		for emotionItem in motivesItems{
			emotionItem.checked = false
		}
		for emotionItem in behavioursItems{
			emotionItem.checked = false
		}
		item.checked = true
	}
	
	func addItem(_ item : EmotionItem, for psychology: Psychology, at index : Int = -1){
		switch psychology{
		case .feelings:
			if index < 0 {
			feelingsItems.append(item)
			} else {
				feelingsItems.insert(item, at: index)
			}
		case .situations:
			if index < 0 {
			motivesItems.append(item)
			}else {
				motivesItems.insert(item, at: index)
			}
		case .behaviours:
			if index < 0 {
				behavioursItems.append(item)
			}else {
				behavioursItems.insert(item, at: index)
			}
		case .solutions:
			if index < 0 {
				solutionsItems.append(item)
			}else {
				solutionsItems.insert(item, at: index)
			}
		}
	}
	
	func newItem()-> EmotionItem{
		let item = EmotionItem(text: "", isReflector: false)
		behavioursItems.append(item)
		return item
	}

	func move(item : EmotionItem, from sourcePsychology: Psychology, at sourceIndex: Int, to destinitionPsychology: Psychology, at destinationIndex : Int) {
		remove(item, from: sourcePsychology, at: sourceIndex)
		addItem(item, for: destinitionPsychology, at: destinationIndex)
	}
	
	func remove(_ item: EmotionItem, from psychology: Psychology, at index: Int){
		switch psychology{
		case .feelings: feelingsItems.remove(at: index)
		case .situations: motivesItems.remove(at : index)
		case .behaviours: behavioursItems.remove(at: index)
		case .solutions: solutionsItems.remove(at: index)
		}
	}
	
	private func randomTitle() -> String{
		var format = ["text",
									"video",
									"audio",
									"image"]
		return format[Int.random(in: 0 ... format.count - 1)]
	}
}

extension EmotionItems : Hashable{
	static func == (lhs: EmotionItems, rhs: EmotionItems) -> Bool {
		return lhs.feelingsItems == rhs.feelingsItems && lhs.motivesItems == rhs.motivesItems && lhs.behavioursItems == rhs.behavioursItems && lhs.solutionsItems == rhs.solutionsItems && lhs.ringPosition == rhs.ringPosition && lhs.name == rhs.name
	}
	func hash(into hasher: inout Hasher) {
		hasher.combine(feelingsItems)
		hasher.combine(motivesItems)
		hasher.combine(behavioursItems)
		hasher.combine(ringPosition)
		hasher.combine(name)
	}
}
