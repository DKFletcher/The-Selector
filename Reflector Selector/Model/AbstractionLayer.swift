//
//  Array.swift
//  Reflector Selector
//
//  Created by Donald Fletcher on 02/03/2020.
//  Copyright © 2020 whatmotivateslearning. All rights reserved.
//


import UIKit

enum AbstractionLayerError: Error{
	case encodingError, decodingError
}

struct QA : Decodable, Encodable{
	let question : String
	let answer : String
	
	init (quest question : String, ans answer : String){
		self.question = question
		self.answer = answer
	}
}

struct Emotion : Decodable, Encodable{
	let name : String
	let worksheet : [QA]
	let custom : Bool
	
	init(emotion name : String, work sheet : [QA], custom image : Bool){
		self.name = name
		self.worksheet = sheet
		self.custom = image
	}
}

struct AbstractionLayerForImage : Encodable, Decodable{
	let image : Image
	init(image : Image){
		self.image = image
	}
}

struct Image : Decodable, Encodable {
	let emotion : String
	let image : String
	
	init(emotion : String, image: String){
		self.emotion = emotion
		self.image = image
	}
}

struct AbstractionLayerForImages : Encodable, Decodable{
	let images : [Image]
	
	init(images : [Image]){
 		self.images = images
	}
}

struct AbstractionLayerForText: Decodable, Encodable {
	let name : String?
	let emotions : [Emotion]
	let phase : EmotionItems.Phase
	
	init(fileName : URL) throws {
		let decoder = JSONDecoder()
		let data = try Data(contentsOf: fileName)
		self = try decoder.decode(AbstractionLayerForText.self, from: data)
	}
	
	init(){
		self.name = ""
		self.emotions = []
		self.phase = .first
	}
	
	init (user name : String?, emotions feelings : [Emotion], for phase : EmotionItems.Phase){
		self.name = name
		self.emotions = feelings
		self.phase = phase
	}
}




struct Page: Encodable, Decodable {
	enum Side : String, Encodable, Decodable {
		case front = "front"
		case back = "back"
	}
	
	let side : Side
	let included : Bool
	let name : String?
	
	init (onDisplay side : Side, inGame included : Bool, for card : String?){
		self.side = side
		self.included = included
		self.name = card
	}
	
	init(){
		self.side = .front
		self.included = true
		self.name = nil
	}
}

struct AbstractionLayerForWorkbook: Encodable, Decodable{
	let workBook : [Page]
	
	init (for pages : [Page]){
		self.workBook = pages
	}
	
	init(){
		self.workBook = [Page()]
	}
}



enum DecodingError: Error {
	case missingFile
}
