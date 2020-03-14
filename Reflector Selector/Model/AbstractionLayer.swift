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
	
	init(fileName : URL) throws {
		let decoder = JSONDecoder()
		let data = try Data(contentsOf: fileName)
		self = try decoder.decode(AbstractionLayerForText.self, from: data)
	}
	
	init(){
		self.name = ""
		self.emotions = []
	}
	
	init (user name : String?, emotions feelings : [Emotion]){
		self.name = name
		self.emotions = feelings
	}
}

//struct  AbstractionLayer: Decodable, Encodable {
//	let name : String?
//	let emotions : [Emotion]
//	let image : String?
//
//	init(fileName : URL) throws {
//		let decoder = JSONDecoder()
//		let data = try Data(contentsOf: fileName)
//		self = try decoder.decode(AbstractionLayer.self, from: data)
//	}
//	init(){
//		self.name = ""
//		self.emotions = []
//		self.image = ""
//	}
//	init (user name : String?, emotions feelings : [Emotion], frontPageImage image : String?){
//		self.name = name
//		self.emotions = feelings
//		self.image = image
//	}
//}
enum DecodingError: Error {
	case missingFile
}
