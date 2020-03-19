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

	@IBOutlet var webView: WKWebView!
	override func viewDidLoad() {
        super.viewDidLoad()
				navigationController?.navigationBar.isHidden = false
			if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
				webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
			}
    }
}
