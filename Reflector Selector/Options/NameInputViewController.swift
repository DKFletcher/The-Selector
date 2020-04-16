//
//  NameInputViewController.swift
//  Reflector Selector
//
//  Created by Donald Fletcher on 16/04/2020.
//  Copyright © 2020 whatmotivateslearning. All rights reserved.
//

import UIKit

class NameInputViewController: UIViewController {

	@IBOutlet var textField: UITextField!
	override func viewDidLoad() {
			super.viewDidLoad()
			navigationController?.navigationBar.isHidden = false
    }
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		textField.becomeFirstResponder()
		textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
		if let name = (tabBarController as! TabBarController).learnerName{
			textField.text = name
		}
	}
	
	@objc func textFieldDidChange(_ textField: UITextField) {
		(tabBarController as! TabBarController).learnerName = textField.text
		(tabBarController as! TabBarController).optionsChanged()
	}
}
