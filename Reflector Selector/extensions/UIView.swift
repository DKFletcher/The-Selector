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

extension UIView {
	func centeredAttributedString(_ string : String) -> NSAttributedString{
		let font : UIFont = getFont()
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .center
		return NSAttributedString(string: string, attributes : [.paragraphStyle: paragraphStyle, .font: font])
	}
	
	func leftAttributedString(_ string : String) -> NSAttributedString{
		let font : UIFont = getFont()
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .left
		return NSAttributedString(string: string, attributes : [.paragraphStyle: paragraphStyle, .font: font])
	}
	
	func rightAttributedString(_ string : String) -> NSAttributedString{
		let font : UIFont = getFont()
		let paragraphStyle = NSMutableParagraphStyle()
		paragraphStyle.alignment = .right
		return NSAttributedString(string: string, attributes : [.paragraphStyle: paragraphStyle, .font: font])
	}
	
	func getFont() -> UIFont{
		var font = UIFont.preferredFont(forTextStyle: .body).withSize(fontSize)
		font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
		return font
	}
	struct SizeRatio {
		static let fontSizeToBoundsWidth: CGFloat = 0.064
		static let labelRatioHeightFontSize: CGFloat = 1.8
		static let boxOffset: CGFloat = 5
	}
	var fontSize: CGFloat {
		return 16//bounds.size.height * SizeRatio.fontSizeToBoundsWidth
	}
	
	var questionHeight: CGFloat {
		return fontSize * SizeRatio.labelRatioHeightFontSize
	}
	
	func offset(from box : CGRect) -> CGRect{
		return CGRect(x: CGFloat(box.minX) + SizeRatio.boxOffset,
									y: CGFloat(box.minY) + SizeRatio.boxOffset,
									width: box.width - SizeRatio.boxOffset * 2,
									height: box.height - SizeRatio.boxOffset * 2)
	}
}


extension UIView {
  func addSubview(
    _ subview: UIView,
    constrainedTo anchorsView: UIView, widthAnchorView: UIView? = nil,
    multiplier: CGFloat = 1
  ) {
    addSubview(subview)
    subview.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      subview.centerXAnchor.constraint(equalTo: anchorsView.centerXAnchor),
      subview.centerYAnchor.constraint(equalTo: anchorsView.centerYAnchor),
      subview.widthAnchor.constraint(
        equalTo: (widthAnchorView ?? anchorsView).widthAnchor,
        multiplier: multiplier
      ),
      subview.heightAnchor.constraint(
        equalTo: anchorsView.heightAnchor,
        multiplier: multiplier
      )
    ])
  }

  func animateIn(handleCompletion: ( () -> Void )? = nil) {
    transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
    alpha = 0
    isHidden = false

    UIView.animate(
      withDuration: 0.5,
      delay: 0,
      usingSpringWithDamping: 0.4,
      initialSpringVelocity: 0.5,
      animations: {
        self.alpha = 1
        self.transform = .identity
      },
      completion: handleCompletion.map { handleCompletion in
        { _ in handleCompletion() }
      }
    )
  }

	func menuAnimateIn(handleCompletion: ( () -> Void )? = nil) {
		transform = CGAffineTransform.identity.scaledBy(x: 0.5, y: 0.5)
		alpha = 0
		isHidden = false
		
		UIView.animate(
			withDuration: 0.5,
			delay: 0,
			usingSpringWithDamping: 0.8,
			initialSpringVelocity: 0.1,
			animations: {
				self.alpha = 1
				self.transform = .identity
		},
			completion: handleCompletion.map { handleCompletion in
				{ _ in handleCompletion() }
			}
		)
	}

	
  func roundCorners() {
//    layer.cornerRadius = {
//      let cardRadius = bounds.maxX / 6
//      switch self {
//      case is CardView, is CardSuperview:
//        return cardRadius
//      default:
//        return cardRadius / 3
//      }
//    } ()
  }
}
