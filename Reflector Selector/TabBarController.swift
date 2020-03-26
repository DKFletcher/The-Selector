//
//  PDFViewController.swift
//  WML
//
//  Created by Donald Fletcher on 30/12/2019.
//  Copyright © 2019 Donald Fletcher. All rights reserved.
//
import UIKit
var imageServer = ImageServer()
class TabBarController: UITabBarController {
	
	var phase : EmotionItems.Phase = .third {
		didSet{
			print("phase didSet: \(phase)")
			setForPhase(cards: cards)
		}
	}
	
	var helpState : HelpMenuItem = .home
	
	var learnerName : String?
	
	var emotions : [Card]! {
		didSet{
			setForPhase(cards: emotions)
			print("didSet")
		}
	}
	
	var frontCover : UIImage? = nil
	
	var imageAbstractionLayer : AbstractionLayerForImages {
		get{
			return AbstractionLayerForImages(images: imageServer.get64())
		}
		set{
			imageServer.flushServer()
			newValue.images.forEach{ image in
				let base64String = image.image
				if let imageData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters){
					if let imageUI = UIImage(data: imageData){
						imageServer.set(emotion: image.emotion, image: imageUI)
					}
				}else{
					print("image error")
				}
			}
		}
	}
	
	func getAbstractionLayerForImage(named emotion : Card) -> AbstractionLayerForImage?{
		if let base64 = imageServer.get64(for: emotion){
			return AbstractionLayerForImage(image: base64)
		} else { return nil }
	}
	
	func setAbstractionLayerForImage (image : AbstractionLayerForImage){
		let base64String = image.image.image
		if let imageData = Data(base64Encoded: base64String, options: .ignoreUnknownCharacters){
			if let imageUI = UIImage(data: imageData){
				imageServer.set(emotion: image.image.emotion, image: imageUI)
			}
		}else{
			print("image error")
		}
	}
	
	var abstractionLayer : AbstractionLayerForText {
		get {
			
			print("abstraction layer  get")
			var em : [Emotion] = []
			emotions.forEach { card in
				let emotionName = card.name
				var worksheet : [QA] = []
				card.emotion.qanda.sections().forEach{ questionAnswer in
					worksheet.append(QA(quest: questionAnswer[0].question, ans: questionAnswer[0].answer))
				}
				let emotion = Emotion(emotion: emotionName, work: worksheet, custom : card.emotion.custom)
				em.append(emotion)
			}
			return AbstractionLayerForText(user: learnerName, emotions: em, for: phase)
		}
		set {
			print("phase: \(newValue.phase)")
			phase = .third
			imageServer.flushServer()
			learnerName = newValue.name
			emotions.forEach { card in card.emotion.qanda.sections().forEach{ questions in questions.forEach{ question in
				newValue.emotions.forEach{ emotion in
					if emotion.name == card.name{
						card.emotion.custom = emotion.custom
						emotion.worksheet.forEach{qa in
							if qa.question == question.question {
								question.answer = qa.answer}}}
					
				}
				}}}
			phase = newValue.phase
		}
	}
	
	var abstractedWorkbook : AbstractionLayerForWorkbook?
	
	
	var cards : [Card]! {
		get{
			var phaseCards : [Card] = []
			switch phase {
			case .first: return emotions.filter { $0.emotion.phase == .first }
			case .second:
				emotions.filter { $0.emotion.phase == .first }.forEach { phaseCards.append($0) }
				emotions.filter { $0.emotion.phase == .second }.forEach { phaseCards.append($0) }
				return phaseCards
			case .third: return emotions
			}
		}
	}
	
	
	var dummy : Card {
		return cards[0]
	}
	
	
	private func setForPhase(cards emotes : [Card]){
		lessonViewController.cards = emotes
		cardSelectionViewController.setCards(emotes)
		cardSelectionViewController.handleSelection = { [unowned lessonViewController]
			card, selected in
			if selected{
				lessonViewController.cards.append(card)
			}
			else {
				lessonViewController.cards.removeAll {$0 == card}
			}
		}
		delegate = self;
	}
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let _ = lessonViewController.cards
//		phase = .third
	}
	
	
	var edit : Bool = false
	
	var teacherMode : Bool {
		//		return edit && phase == .third
		return true
	}
	
	var settingsViewController : OptionsViewController {
		return viewControllers![2] as! OptionsViewController
	}
	
	var cardSelectionViewController: CardSelectionViewController{
		let nav = viewControllers![1] as! CardSelectionNavigationController
		return nav.viewControllers.first as! CardSelectionViewController
	}
	
	var lessonViewController : LessonViewController {
		let activityNavigationController = viewControllers![0] as! ActivityNavigationController
		return activityNavigationController.viewControllers.first as! LessonViewController
	}
}

extension TabBarController: UITabBarControllerDelegate {
	func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController)->Bool{
		return cardSelectionViewController.cellModels.filter { $0.selected } .count >= 4
	}
}




extension TabBarController{
	func textToChange(text changed: QuestionAnswer){
		do{
			let encoder = JSONEncoder()
			self.emotions.forEach{card in card.emotion.qanda.sections().forEach{ questions in questions.forEach{ question in
				if changed == question {
					question.answer = changed.answer
					cardSelectionViewController.propagate(emotionSelection: card)
				}
				}}}
			let emotions = abstractionLayer
			let documentData = try encoder.encode(emotions)
			do{
				try self .fileSave(directory: .applicationSupportDirectory, fileName: "worksheets", directoryName: "./", documentData: documentData, pathExtension: "txt")
			} catch {
				print(error)
			}
		} catch { print(error)}
	}
	
	func workbookToChange(workbook abstractionLayerForWorkbook : AbstractionLayerForWorkbook){
		do {
			let encoder = JSONEncoder()
			let documentData = try encoder.encode(abstractionLayerForWorkbook)
			do {
				try self .fileSave(directory: .applicationSupportDirectory, fileName: "workbook", directoryName: "./", documentData: documentData, pathExtension: "txt")
			} catch {
				print(error)
			}
		} catch { print(error)}
		
	}
	
	func optionsChanged(){
		do {
			let encoder = JSONEncoder()
			let data = abstractionLayer
			let documentData = try encoder.encode(data)
			do{
				try self .fileSave(directory: .applicationSupportDirectory, fileName: "worksheets", directoryName: "./", documentData: documentData, pathExtension: "txt")
			} catch {
				print(error)
			}
		}  catch { print(error)}
	}
	
	func changeImageDisplayed(for card: Card){
		self.emotions.filter{ $0.name == card.name}[0].emotion.custom = card.emotion.custom
		optionsChanged()
	}
	
	func imagesToChange(image changed: UIImage){
		do{
			let encoder = JSONEncoder()
			let imageData = imageAbstractionLayer
			let documentData = try encoder.encode(imageData)
			do{
				try self .fileSave(directory: .applicationSupportDirectory, fileName: "images", directoryName: "./", documentData: documentData, pathExtension:
				"img")
			} catch {
				print(error)
			}
		} catch { print(error)}
	}
	
	func imageToChange(image change : UIImage, for emotion : Card){
		if let imageData = getAbstractionLayerForImage(named: emotion){
			let encoder = JSONEncoder()
			do{
				let documentData = try encoder.encode(imageData)
				do{
					try self .fileSave(directory: .applicationSupportDirectory, fileName: emotion.name, directoryName: "./", documentData: documentData, pathExtension: "img")
				} catch {
					print(error)
				}
			}catch { print(error)}
		}
	}
	
	func fileSave(directory: FileManager.SearchPathDirectory, fileName: String, directoryName: String, documentData: Data, pathExtension: String) throws {
		let kindDirectoryURL = URL(fileURLWithPath: directoryName, relativeTo: FileManager.default.urls(for: directory, in: .userDomainMask)[0])
		try? FileManager.default.createDirectory(at: kindDirectoryURL, withIntermediateDirectories: false)
		try documentData.write(to: kindDirectoryURL.appendingPathComponent(fileName).appendingPathExtension(pathExtension), options: .atomic)
	}
}
