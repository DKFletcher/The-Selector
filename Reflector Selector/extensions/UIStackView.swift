//
//  UIStackView.swift
//  Reflector Selector
//
//  Created by Donald Fletcher on 13/03/2020.
//  Copyright © 2020 whatmotivateslearning. All rights reserved.
//

import UIKit


extension UIStackView {
	
	func addBackground(named imageName: String) {
		let subview = UIView(frame: bounds)
		let imageView = UIImageView()
		imageView.image = UIImage(named: imageName)!
		imageView.frame = CGRect(x: 0.0, y: 0.0, width: self.frame.width, height: self.frame.height)
		subview.addSubview(imageView)
		subview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
		insertSubview(subview, at: 0)
	}
	
}
