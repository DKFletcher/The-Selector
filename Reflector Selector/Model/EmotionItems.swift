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

struct Index{
	let emotion : Emotion
	let zone : Zone
	let dimension : Dimension
	let quadrant : Quadrant
	let position : Int
	
	init(emotion: Emotion, position: Int){
		self.position = position
		self.emotion = emotion
		self.zone = self.emotion.zone(emotion: self.emotion)
		self.dimension = self.zone.dimension(zone: self.zone)
		self.quadrant = self.zone.quadrant(zone: self.zone)
	}
	
	enum Emotion : String, CaseIterable{
		case determined = "Determined"
		case enthusiastic = "Enthusiastic"
		case bold = "Bold"
		case hopeful = "Hopeful"
		case admiring = "Admiring"
		case curious = "Curious"
		case proud = "Proud"
		case confident = "Confident"
		case valued = "Valued"
		case exhilarated = "Exhilatated"
		case belonging = "Belonging"
		case trusting = "Trusting"
		case playful = "Playful"
		case content = "Content"
		case thankful = "Thankful"
		case kind = "Kind"
		case empatheticJoy = "Empathetic Joy"
		case responsible = "Responsible"
		case compassionate = "Compassionate"
		case forgiving = "Forgiving"
		case lonely = "Lonely"
		case sad = "Sad"
		case selfDoubting = "Self-Doubting"
		case worried = "Worried"
		case overwhelmed = "Overwhelmed"
		case embarrassed = "Embarrassed"
		case guilty = "Guilty"
		case ashamed = "Ashamed"
		case humiliated = "Humiliated"
		case ignored = "Ignored"
		case spiteful = "Spiteful"
		case contempt = "Contempt"
		case resentful = "Resentful"
		case entitled = "Entitled"
		case arrogant = "Arrogant"
		case envious = "Envious"
		case gloating = "Gloating"
		case angry = "Angry"
		case frustrated = "Frustrated"
		case bored = "Bored"
		
		func zone ( emotion : Emotion) -> Zone{
			switch emotion{
			case .determined: return .driven
			case .enthusiastic: return .driven
			case .bold: return .gutsy
			case .hopeful: return .gutsy
			case .admiring: return .gutsy
			case .curious: return .gutsy
			case .proud: return .chuffed
			case .confident: return .chuffed
			case .valued: return .thrilled
			case .exhilarated: return .thrilled
				
			case .belonging: return .incluced
			case .trusting: return .incluced
			case .playful: return .incluced
			case .content: return .gracious
			case .thankful: return .gracious
			case .kind: return .caring
			case .empatheticJoy: return .caring
			case .responsible: return .caring
			case .compassionate: return .patient
			case .forgiving: return .patient
				
			case .lonely: return . flat
			case .sad: return . flat
			case .selfDoubting: return .wobbly
			case .worried: return . wobbly
			case .overwhelmed: return .wobbly
			case .embarrassed: return .sheepish
			case .guilty: return .sheepish
			case .ashamed: return .sheepish
			case .humiliated: return .useless
			case .ignored: return .useless
				
			case .spiteful: return .mean
			case .contempt: return .mean
			case .resentful: return .mean
			case .entitled: return . spoilt
			case .arrogant: return .spoilt
			case .envious: return .grudging
			case .gloating: return .grudging
			case .angry: return .annoyed
			case .frustrated: return .annoyed
			case .bored: return .annoyed
			}
		}
	}

	enum Zone: String, CaseIterable{
		case driven = "Driven"
		case gutsy = "Gutsy"
		case chuffed = "Chuffed"
		case thrilled = "Thrilled"
		case incluced = "Included"
		case gracious = "Gracious"
		case caring = "Caring"
		case patient = "Patient"
		case flat = "Flat"
		case wobbly = "Wobbly"
		case sheepish = "Sheepish"
		case useless = "Useless"
		case mean = "Mean"
		case spoilt = "Spoilt"
		case grudging = "Grudging"
		case annoyed = "Annoyed"
		
		func dimension( zone : Zone) -> Dimension{
			switch zone{
			case .annoyed: return .acceptance
			case .caring: return .kindness
			case .chuffed: return .status
			case .driven: return .determination
			case .flat: return .determination
			case .gracious: return .gratitude
			case .grudging: return .kindness
			case .gutsy: return .ambition
			case .incluced: return .security
			case .mean: return .security
			case .patient: return .acceptance
			case .sheepish: return .status
			case .spoilt: return .gratitude
			case .thrilled: return .fulfilment
			case .useless: return .fulfilment
			case .wobbly: return .ambition
			}
		}
		
		func quadrant (zone : Zone) -> Quadrant{
			switch zone{
			case .annoyed: return .meFirst
			case .caring: return .connectingMe
			case .chuffed: return .stretchingMe
			case .driven: return .stretchingMe
			case .flat: return .protectingMe
			case .gracious: return .connectingMe
			case .grudging: return .meFirst
			case .gutsy: return .stretchingMe
			case .incluced: return .connectingMe
			case .mean: return .meFirst
			case .patient: return .connectingMe
			case .sheepish: return .protectingMe
			case .spoilt: return .meFirst
			case .thrilled: return .stretchingMe
			case .useless: return .protectingMe
			case .wobbly: return .protectingMe
			}
		}
		
	}

	enum Dimension: String, CaseIterable{
		case fulfilment = "Fulfilment"
		case status = "Status"
		case ambition = "Ambition"
		case determination = "Determination"
		case security = "Security"
		case kindness = "Kindness"
		case gratitude = "Gratitude"
		case acceptance = "Acceptance"
	}

	enum Quadrant: String, CaseIterable{
		case stretchingMe = "Stretching Me"
		case connectingMe = "Connecting Me"
		case meFirst = "Me First"
		case protectingMe = "Protecting Me"
	}
	
}

class EmotionItems{
	var custom : Bool = false
	
	let index : Index
	
	enum Quadrant: String, CaseIterable{
		case stretchingMe = "stretchingMe"
		case connectingMe = "connectingMe"
		case protectingMe = "protectingMe"
		case meFirst = "meFirst"
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
								 stage age : Phase = Phase.third,
								 ring quadrant : Quadrant,
								 emotion index : Index,
								 worksheet qanda : Worksheet){
		//		self.image = UIImage(named: byName)!
		self.name = byName
		self.phase = age
		self.qanda = qanda
		self.quadrant = quadrant
		self.index = index
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
