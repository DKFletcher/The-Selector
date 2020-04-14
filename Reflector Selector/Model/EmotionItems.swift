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
	
	func getPDFName( for name : String) ->String?{
		switch name{
		case "Determined": return "Determined"
		case "Enthusiastic": return "Enthusiastic"
		case "Bold": return "Bold"
		case "Hopeful": return "Hopeful"
		case "Admiring": return "Admiring"
		case "Curious": return "Curious"
		case "Proud": return "Proud"
		case "Confident": return "Confident"
		case "Valued": return "Valued"
		case "Joy": return "Joy"
		case "Belonging": return "Belonging"
		case "Trusting": return "Trust"
		case "Playful": return "Playfulness"
		case "Content": return "Content"
		case "Thankful": return "Thankful"
		case "Kind": return "Kind"
		case "Pleased for Others": return "Pleased for Others"
		case "Responsible": return "Responsible"
		case "Compassionate": return "Compassionate"
		case "Forgiving": return "Forgiveness"
		case "Lonely": return "Lonely"
		case "Sad": return "Sad"
		case "Self-Doubting": return "Self-Doubting"
		case "Worried": return "Worried"
		case "Overwhelmed": return "Overwhelmed"
		case "Embarrassed": return "Embarrassed"
		case "Guilty": return "Guilty"
		case "Ashamed": return "Shame"
		case "Humiliated": return "Humiliated"
		case "Ignored": return "Inferior"
		case "Spiteful": return "Spiteful"
		case "Contempt": return "Contempt"
		case "Resentful": return "Resentful"
		case "Entitled": return "Entitled"
		case "Arrogant": return "Arrogant"
		case "Envious": return "Envy"
		case "Gloating": return "Gloating"
		case "Angry": return "Angry"
		case "Frustrated": return "Frustrated"
		case "Bored": return "Bored"
			
		case "Stretching Me": return "stretchingMe"
		case "Connecting Me": return "connectingMe"
		case "Me First": return "meFirst"
		case "Protecting Me": return "protectingMe"
			
		case "Fulfilled": return "Fulfilled"
		case "Significant": return "Significant"
		case "Adventurous": return "Adventurous"
		case "Energised": return "Energised"
		case "Annoyed": return "Annoyed"
		case "Grudging": return "Grudging"
		case "Ungrateful": return "Ungrateful"
		case "Mean": return "Mean"
		case "Worthless": return "Worthless"
		case "Unworthy": return "Unworthy"
		case "Insecure": return "Insecure"
		case "Low": return "Low"
		case "Patient": return "Patient"
		case "Caring": return "Caring"
		case "Appreciative": return "Appreciative"
		case "Warm": return "Warm"
		default: return nil
		}
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
		case exhilarated = "Joy"
		case belonging = "Belonging"
		case trusting = "Trusting"
		case playful = "Playful"
		case content = "Content"
		case thankful = "Thankful"
		case kind = "Kind"
		case pleasedForOthers = "Pleased for Others"
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
			case .determined: return .energised
			case .enthusiastic: return .energised
			case .bold: return .adventurous
			case .hopeful: return .adventurous
			case .admiring: return .adventurous
			case .curious: return .adventurous
			case .proud: return .significant
			case .confident: return .significant
			case .valued: return .fulfilled
			case .exhilarated: return .fulfilled
				
			case .belonging: return .warm
			case .trusting: return .warm
			case .playful: return .warm
			case .content: return .appreciative
			case .thankful: return .appreciative
			case .kind: return .caring
			case .pleasedForOthers: return .caring
			case .responsible: return .caring
			case .compassionate: return .patient
			case .forgiving: return .patient
				
			case .lonely: return .low
			case .sad: return .low
			case .selfDoubting: return .insecure
			case .worried: return .insecure
			case .overwhelmed: return .insecure
			case .embarrassed: return .unworthy
			case .guilty: return .unworthy
			case .ashamed: return .unworthy
			case .humiliated: return .worthless
			case .ignored: return .worthless
				
			case .spiteful: return .mean
			case .contempt: return .mean
			case .resentful: return .mean
			case .entitled: return .ungrateful
			case .arrogant: return .ungrateful
			case .envious: return .grudging
			case .gloating: return .grudging
			case .angry: return .annoyed
			case .frustrated: return .annoyed
			case .bored: return .annoyed
			}
		}
	}

	enum Zone: String, CaseIterable{
		case energised = "Energised"
		case adventurous = "Adventurous"
		case significant = "Significant"
		case fulfilled = "Fulfilled"
		case warm = "Warm"
		case appreciative = "Appreciative"
		case caring = "Caring"
		case patient = "Patient"
		case low = "Low"
		case insecure = "Insecure"
		case unworthy = "Unworthy"
		case worthless = "Worthless"
		case mean = "Mean"
		case ungrateful = "Ungrateful"
		case grudging = "Grudging"
		case annoyed = "Annoyed"
		
		func dimension( zone : Zone) -> Dimension{
			switch zone{
			case .annoyed: return .acceptance
			case .caring: return .kindness
			case .significant: return .status
			case .energised: return .determination
			case .low: return .determination
			case .appreciative: return .gratitude
			case .grudging: return .kindness
			case .adventurous: return .ambition
			case .warm: return .security
			case .mean: return .security
			case .patient: return .acceptance
			case .unworthy: return .status
			case .ungrateful: return .gratitude
			case .fulfilled: return .fulfilment
			case .worthless: return .fulfilment
			case .insecure: return .ambition
			}
		}
		
		func quadrant (zone : Zone) -> Quadrant{
			switch zone{
			case .annoyed: return .meFirst
			case .caring: return .connectingMe
			case .significant: return .stretchingMe
			case .energised: return .stretchingMe
			case .low: return .protectingMe
			case .appreciative: return .connectingMe
			case .grudging: return .meFirst
			case .adventurous: return .stretchingMe
			case .warm: return .connectingMe
			case .mean: return .meFirst
			case .patient: return .connectingMe
			case .unworthy: return .protectingMe
			case .ungrateful: return .meFirst
			case .fulfilled: return .stretchingMe
			case .worthless: return .protectingMe
			case .insecure: return .protectingMe
			}
		}
		
	}

	enum Dimension: String, CaseIterable{
		case fulfilment = "Purpose"
		case status = "Status"
		case ambition = "Ambition"
		case determination = "Vitality"
		case security = "Affection"
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
