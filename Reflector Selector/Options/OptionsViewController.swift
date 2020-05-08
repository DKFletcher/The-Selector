//
//  SettingsViewController.swift
//  WML
//
//  Created by Donald Fletcher on 30/01/2020.
//  Copyright © 2020 Donald Fletcher. All rights reserved.
//

import UIKit
class OptionsViewController: UIViewController, UINavigationControllerDelegate {
	@IBOutlet var refelectorSelectorBook: UIButton!
	@IBOutlet var phaseInfo: UILabel!
	@IBOutlet var phaseOne : UIButton!
	@IBOutlet var phaseTwo : UIButton!
	@IBOutlet var phaseThree : UIButton!
	
	@IBOutlet var logBook: UIButton!
	
	@IBAction func logBook(_ sender: Any) {
			self.performSegue(withIdentifier: "PDFSegue", sender: PDFViewController.Jobs.Logbook)
	}
	
	@IBAction func reflectorSelector(_ sender: Any) {
				DispatchQueue.main.async {
					self.performSegue(withIdentifier: "PDFSegue", sender: PDFViewController.Jobs.Handbook)
		}
	}
	@IBOutlet var nameLabel: UILabel!

	@objc func preferredContentSizeChanged(_ notification : Notification){}
	
	@IBAction func didTapTextField(_ sender : UITapGestureRecognizer){
		performSegue(withIdentifier: "NameSegue", sender: sender)
	}
	
	
	@IBAction func phase(_ sender: UIButton) {
		setButtons(for: sender)
		if let activePhase = sender.titleLabel?.text {
			var phaseSet : EmotionItems.Phase
			switch activePhase{
			case "Phase 1":
				phaseSet = .first
			case "Phase 2":
				phaseSet = .second
			case "Phase 3":
				phaseSet = .third
			default:
				phaseSet = .first
			}
			phaseOn(phase: phaseSet)
			
			(self.tabBarController as! TabBarController).phase = phaseSet
			(tabBarController as! TabBarController).optionsChanged()
		}
	}
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		NotificationCenter.default.addObserver(self, selector: #selector(preferredContentSizeChanged(_:)), name: UIContentSizeCategory.didChangeNotification, object: nil)
		
		
		switch (self.tabBarController as! TabBarController).phase{
		case .first: setButtons(for: phaseOne)
		case .second: setButtons(for: phaseTwo)
		case .third: setButtons(for: phaseThree)
		}
		navigationController?.navigationBar.isHidden = true
		refelectorSelectorBook.titleLabel!.textAlignment = .center
		
		let tap = UITapGestureRecognizer(target: self, action: #selector(didTapTextField(_:)))
		nameLabel.addGestureRecognizer(tap)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		navigationController?.navigationBar.isHidden = true
		phaseOn(phase: (tabBarController as! TabBarController).phase)
		if let name = (tabBarController as! TabBarController).learnerName{
			nameLabel.text = name
		} else {
			nameLabel.text = "Tap here to enter your name..."
		}
	}
	
	private func phaseOn(phase activePhase : EmotionItems.Phase) {
			switch activePhase{
			case .first:
				phaseInfo.text = "12 emotions"
			case .second:
				phaseInfo.text = "23 emotions"
			case .third:
				phaseInfo.text = "40 emotions"
			}
	}
	
	private func setButtons(for selected : UIButton){
		phaseOne.setTitleColor(.black, for: .normal)
		phaseTwo.setTitleColor(.black, for: .normal)
		phaseThree.setTitleColor(.black, for: .normal)
		phaseOne.setBackgroundImage(UIImage(named: "button up"), for: .normal)
		phaseTwo.setBackgroundImage(UIImage(named: "button up"), for: .normal)
		phaseThree.setBackgroundImage(UIImage(named: "button up"), for: .normal)
		
		selected.setTitleColor(.white, for: .normal)
		selected.setBackgroundImage(UIImage(named: "button sellected"), for: .normal)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "PDFSegue"{
			let pdfViewController = segue.destination as! PDFViewController
			pdfViewController.card = (tabBarController as! TabBarController).dummy
			pdfViewController.job = sender as! PDFViewController.Jobs
			
		}
	}
}
