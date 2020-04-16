/// Copyright (c) 2018 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

protocol CardPDFDelegate{
	func pdfUp(emotion card: Card, edit front: Bool)
}

class BackCardView: CardView, CardPDFDelegate{
	func pdfUp(emotion card: Card, edit front: Bool) {
		delegate?.pdfUp(emotion: card, edit: front)
	}
	
	
	@IBOutlet var label: UILabel!
	private var longToSet = true
	var delegate :  CardPDFDelegate?
	override var card: Card! {
		didSet {
			
			label.text = card.name
			
			if longToSet{
				let longPress1 = UILongPressGestureRecognizer(target: self, action: #selector(pdf))
				longPress1.minimumPressDuration = TimeInterval(0.5)
				longPress1.numberOfTouchesRequired = 1
				self.addGestureRecognizer(longPress1)
				
				let longPress2 = UILongPressGestureRecognizer(target: self, action: #selector(pdf))
				longPress2.minimumPressDuration = TimeInterval(0.5)
				longPress2.numberOfTouchesRequired = 2
				self.addGestureRecognizer(longPress2)

				longToSet = false
			}
		}
	}
	
	
	override var side: Side {
		return .back
	}
	
	@objc func pdf(sender: UILongPressGestureRecognizer){
		if sender.state == UIGestureRecognizer.State.began {
			switch sender.numberOfTouchesRequired {
			case 1 :
				pdfUp(emotion: card, edit: false)
			case 2 :
				pdfUp(emotion: card, edit: true)
			default :
				print("longPress firing on other signal: \(sender)")
			}
		}
	}
}
