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
	
	override func viewDidLoad() {
		super.viewDidLoad()
//		navigationController?.navigationBar.isHidden = false
		instructionViewport.addSubview(homeView, constrainedTo: instructionViewport, widthAnchorView: instructionViewport, multiplier: 1.0)
		instructionViewport.addSubview(notebookView, constrainedTo: instructionViewport, widthAnchorView: instructionViewport, multiplier: 1.0)
		instructionViewport.addSubview(optionsView, constrainedTo: instructionViewport, widthAnchorView: instructionViewport, multiplier: 1.0)
		setMenu()
	}
	
	private func setMenu(){
		optionsButton.titleLabel?.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
		notebookButton.titleLabel?.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
		homeButton.titleLabel?.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
		homeView.alpha = 0.0
		notebookView.alpha = 0.0
		optionsView.alpha = 0.0
		switch (tabBarController as! TabBarController).helpState{
			case .home:
				homeButton.setTitleColor(#colorLiteral(red: 0.9921568627, green: 0.6980392157, blue: 0.1450980392, alpha: 1), for: .normal)
				homeView.menuAnimateIn()
			case .notebook:
				notebookButton.setTitleColor(#colorLiteral(red: 0.9921568627, green: 0.6980392157, blue: 0.1450980392, alpha: 1), for: .normal)
				notebookView.menuAnimateIn()
			case .options:
				optionsButton.setTitleColor(#colorLiteral(red: 0.9921568627, green: 0.6980392157, blue: 0.1450980392, alpha: 1), for: .normal)
				optionsView.menuAnimateIn()
		}
	}
}


enum HelpMenuItem: String{
	case home = "Home"
	case notebook = "Notebook"
	case options = "Options"
}
