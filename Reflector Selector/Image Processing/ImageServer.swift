//
//  ImageServer.swift
//  WML
//
//  Created by Donald Fletcher on 11/02/2020.
//  Copyright © 2020 Donald Fletcher. All rights reserved.
//

import Foundation
import UIKit
struct ImageServer {
	
	private var emotion : Card!
	
	private var customImages : [String : UIImage] = [:]
	
	var customImage : Bool {
		if let _ = customImages[emotion.name]{
			return true
		} else {
			return false
		}
	}
	
	mutating func get(image emotion : Card, high definition: Bool = false) -> UIImage{
		self.emotion = emotion
		if emotion.emotion.custom{
			if let image = customImages[emotion.name]{
				return image
			} else {
				return UIImage()
			}
		} else {
			if definition{
				if let libraryImage = UIImage(named: emotion.name+"_close"){
					return libraryImage
				} else {
					return UIImage()
				}
			}else {
				if let libraryImage = UIImage(named: emotion.name){
					return libraryImage
				} else {
					return UIImage()
				}
			}
		}
	}
	
	mutating func set(emotion string : String, image actorImage : UIImage){
		customImages[string] = actorImage
	}
	
	mutating func get64() -> [Image]{
		var images : [Image] = []
		customImages.forEach{ image in
			if let imageData = image.value.pngData(){
				let base64 = imageData.base64EncodedString(options: .lineLength64Characters)
				images.append(Image(emotion: image.key, image: base64))
			}
		}
		return images
	}
	
	mutating func get64(for emotion : Card) -> Image?{
		self.emotion = emotion
		if customImage{
			let image = get(image: emotion)
			if let imageData = image.pngData(){
				return Image(emotion: emotion.name, image: imageData.base64EncodedString(options: .lineLength64Characters))
			}else { return nil }
		} else { return nil }
	}
	
	mutating func custom( image forEmotion : Card) -> Bool{
		emotion = forEmotion
		return customImage
	}
	
	mutating func flushServer(){
		self.customImages = [:]
	}
}

