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

protocol CardZoomDelegate{
	func closeUp(emotion card: Card)
}

class FrontCardView: CardView, CardZoomDelegate {
	
	private var longToSet = true
	@IBOutlet var imageView: FrontCardImageView!
	var delegate: CardZoomDelegate?
	override var card: Card! {
		didSet {
			imageView.image = imageServer.get(image: card)//UIImage(named: card.name)
			
			if longToSet{
				let longPress = UILongPressGestureRecognizer(target: self, action: #selector(zoomIn))
				longPress.minimumPressDuration = TimeInterval(0.5)
				self.addGestureRecognizer(longPress)
				longToSet = false
			}
		}
	}
	
	func updateImage(){
		imageView.image = imageServer.get(image: card)
	}
	
	override var side: Side {
		return .front
	}
	
	@objc func zoomIn(sender: UILongPressGestureRecognizer){
		if sender.state == UIGestureRecognizer.State.began {
			closeUp(emotion: card)
		}
	}
	
	func closeUp(emotion card: Card){
		delegate?.closeUp(emotion: card)
	}
}


@IBDesignable class FrontCardImageView: UIImageView {
	@IBInspectable var maskImage: UIImage! {
		didSet { }//mask = UIImageView(image: maskImage) }
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		mask?.frame = bounds
	}
}
