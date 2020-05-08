//
//  InstructionsViewController.swift
//  Reflector Selector
//
//  Created by Donald Fletcher on 19/03/2020.
//  Copyright © 2020 whatmotivateslearning. All rights reserved.
//

import UIKit
import WebKit

class InstructionsViewController: UIViewController {
	@IBOutlet var instructionViewport: UIView!
	
	@IBOutlet var homeView: UIView!
	@IBOutlet var notebookView: UIView!
	@IBOutlet var optionsView: UIView!
	
	@IBOutlet var optionsButton: UIButton!
	@IBOutlet var notebookButton: UIButton!
	@IBOutlet var homeButton: UIButton!
	
	@IBAction func menuAction(_ sender: UIButton) {
		var menuItem = HelpMenuItem.home
		if sender == optionsButton { menuItem = HelpMenuItem.options}
		if sender == notebookButton { menuItem = HelpMenuItem.notebook}
		(tabBarController as! TabBarController).helpState = menuItem
		setMenu()
	}
	
	@IBAction func closeButtonAction(_ sender: UIButton) {
//		dismiss(animated: true, completion: nil)
//		navigationController?.dismiss(animated: true, completion: nil)
		navigationController?.popViewController(animated: true)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		instructionViewport.addSubview(homeView, constrainedTo: instructionViewport, widthAnchorView: instructionViewport, multiplier: 1.0)
		instructionViewport.addSubview(notebookView, constrainedTo: instructionViewport, widthAnchorView: instructionViewport, multiplier: 1.0)
		instructionViewport.addSubview(optionsView, constrainedTo: instructionViewport, widthAnchorView: instructionViewport, multiplier: 1.0)
		setMenu()
	}
	
	private func setMenu(){
		optionsButton.setImage(UIImage(named: "C1_dark"), for: .normal)
		notebookButton.setImage(UIImage(named: "L1C_dark"), for: .normal)
		homeButton.setImage(UIImage(named: "Joy_3_1_100_dark"), for: .normal)
		homeView.alpha = 0.0
		notebookView.alpha = 0.0
		optionsView.alpha = 0.0
		switch (tabBarController as! TabBarController).helpState{
			case .home:
				homeButton.setImage(UIImage(named: "Joy_3_1_100"), for: .normal)
				homeView.menuAnimateIn()
			case .notebook:
				notebookButton.setImage(UIImage(named: "L1C"), for: .normal)
				notebookView.menuAnimateIn()
			case .options:
				optionsButton.setImage(UIImage(named: "C1C"), for: .normal)
				optionsView.menuAnimateIn()
		}
	}
}


enum HelpMenuItem: String{
	case home = "Home"
	case notebook = "Notebook"
	case options = "Options"
}
