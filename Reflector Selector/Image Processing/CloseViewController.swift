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

class CloseViewController: UIViewController {
	
	@IBOutlet weak var scrollView: UIScrollView!
	
	@IBOutlet weak var imageView: UIImageView!
	
	var isSet: Bool = false
	
	var card: Card!{
		didSet{
		}
	}
	
	var cameraButton : UIBarButtonItem!
	
	var undoButton : UIBarButtonItem!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.cameraButton = UIBarButtonItem(
			barButtonSystemItem: .camera,
			target: self,
			action: #selector(imagePicker)
		)
		self.undoButton = UIBarButtonItem(
			barButtonSystemItem: .refresh,
			target: self,
			action: #selector(libraryImage)
		)
		navigationController?.navigationBar.isHidden = false
		imageView.image = nil
		imageView.image = imageServer.get(image: card, high: true)
		
		imageView.frame.size = imageView.image!.size
		scrollView.delegate = self
		setZoomParameters(scrollView.bounds.size)
		centerImage()
	}
	
	@objc func imagePicker(){
		self.setZoomParameters(self.scrollView.bounds.size)
		self.centerImage()
		let helper = ImagingHelper(presenter: self, sourceview: imageView)
		helper.pickImage()
	}
	
	@objc func libraryImage(){
		card.emotion.custom = !card.emotion.custom
		imageView.image = imageServer.get(image: card, high: true)
		centerImage()
		(tabBarController as! TabBarController).changeImageDisplayed(for: card)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		if (tabBarController as? TabBarController)!.teacherMode {
			if imageServer.custom(image: card){
				navigationItem.rightBarButtonItems = [cameraButton, undoButton]
			}else{
				navigationItem.rightBarButtonItems = [cameraButton]
			}
		} else {
			navigationItem.rightBarButtonItems = []
		}
	}
	
	override func viewWillLayoutSubviews() {
		setZoomParameters(scrollView.bounds.size)
		centerImage()
	}
	
	func centerImage() {
		let scrollViewSize = scrollView.bounds.size
		let imageSize = imageView.frame.size
		let horizontalSpace = imageSize.width < scrollViewSize.width
			? (scrollViewSize.width - imageSize.width) / 2
			: 0
		let verticalSpace = imageSize.height < scrollViewSize.height
			? (scrollViewSize.height - imageSize.height) / 2
			: 0
		scrollView.contentInset = UIEdgeInsets(
			top: verticalSpace,
			left: horizontalSpace,
			bottom: verticalSpace,
			right: horizontalSpace
		)
	}
	
	func setZoomParameters(_ scrollViewSize: CGSize) {
		let imageSize = imageView.bounds.size
		let widthScale = scrollViewSize.width / imageSize.width
		let heightScale = scrollViewSize.height / imageSize.height
		let minScale = min(widthScale, heightScale)
		
		scrollView.minimumZoomScale = minScale
		scrollView.maximumZoomScale = 12.0
		scrollView.zoomScale = minScale
	}
}






extension CloseViewController: UIScrollViewDelegate {
	func viewForZooming(in scrollView: UIScrollView) -> UIView? {
		return imageView
	}
}






extension CloseViewController: UIImagePickerControllerDelegate {
	public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
		dismiss(animated: true)
	}
	public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
		dismiss(animated: true)
		ImagingHelper.image(infoDictionary: info) { image, error in
			if let error = error {
				print("unable to get image from picker - \(error)")
			}
			else if let image = image {
				let rotationCorrectedImage = image.fixedOrientation()
				imageView.image = rotationCorrectedImage
				imageView.frame.size = imageView.image!.size
				
				let bigSize = image.size.width > image.size.height ? image.size.width : image.size.height
				let scale = TypeSetConstants.pageWidth / bigSize
				let newSize = CGSize(width: image.size.width * scale, height: image.size.height * scale)
				let format = UIGraphicsImageRendererFormat()
				format.opaque = false
				let renderer = UIGraphicsImageRenderer(size: newSize, format: format)
				let newImage = renderer.image { (context) in
					image.draw(in: CGRect(origin: .zero, size: newSize))
				}
				
				
				
				print("extension preprocessing: \(image.size) postprocessing: \(newImage.size)")
				
				imageServer.set(emotion: card.name, image: newImage)
				
				card.emotion.custom = !card.emotion.custom
				(tabBarController as! TabBarController).imageToChange(image: newImage, for : card)
				(tabBarController as! TabBarController).changeImageDisplayed(for: card)
				
				viewWillLayoutSubviews()
				if imageServer.custom(image: card) {
					navigationItem.rightBarButtonItems = [cameraButton, undoButton]
				}
			}
		}
	}
}




extension CloseViewController {
	static let ScaleToWidth : CGFloat = 1028
}




//Code extension to scale images
extension UIImage {
	func scaled(with scale: CGFloat) -> UIImage? {
		// size has to be integer, otherwise it could get white lines
		let size = CGSize(width: floor(self.size.width * scale), height: floor(self.size.height * scale))
		UIGraphicsBeginImageContext(size)
		draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
		let image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		return image
	}
	
	
	var scaledSize : UIImage? {
		get{
			var newImage = UIImage()
			let bigSize = size.width > size.height ? size.width : size.height
			let scale = TypeSetConstants.pageWidth / bigSize
			let newSize = CGSize(width: size.width * scale, height: size.height * scale)
			print("\(size) \(newSize)")
			//			let renderer = UIGraphicsImageRenderer(size: size)
			//			return renderer.image { (context) in
			//				self.draw(in: CGRect(origin: .zero, size: newSize))
			//			}
			UIGraphicsBeginImageContext(newSize)
			let bitmap: CGContext = UIGraphicsGetCurrentContext()!
			bitmap.scaleBy(x: scale, y: scale)
			bitmap.draw(self.cgImage! , in: CGRect(origin: .zero, size: newSize ))
			//			bitmap.draw(in: CGRect(origin: .zero, size: newSize ))
			newImage = UIGraphicsGetImageFromCurrentImageContext()!
			UIGraphicsEndImageContext()
			return newImage
			//		}
		}
	}
	public func imageRotatedByDegrees(degrees: CGFloat) -> UIImage {
		//Calculate the size of the rotated view's containing box for our drawing space
		let rotatedViewBox: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height))
		let t: CGAffineTransform = CGAffineTransform(rotationAngle: degrees * CGFloat.pi / 180)
		rotatedViewBox.transform = t
		let rotatedSize: CGSize = rotatedViewBox.frame.size
		//Create the bitmap context
		UIGraphicsBeginImageContext(rotatedSize)
		let bitmap: CGContext = UIGraphicsGetCurrentContext()!
		//Move the origin to the middle of the image so we will rotate and scale around the center.
		bitmap.translateBy(x: rotatedSize.width / 2, y: rotatedSize.height / 2)
		//Rotate the image context
		bitmap.rotate(by: (degrees * CGFloat.pi / 180))
		//Now, draw the rotated/scaled image into the context
		bitmap.scaleBy(x: 1.0, y: -1.0)
		bitmap.draw(
			self.cgImage!,
			in: CGRect(
				x: -self.size.width / 2,
				y: -self.size.height / 2,
				width: self.size.width,
				height: self.size.height
			)
		)
		let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
		UIGraphicsEndImageContext()
		return newImage
	}
	
	public func fixedOrientation() -> UIImage {
		if imageOrientation == UIImage.Orientation.up {
			return self
		}
		var transform: CGAffineTransform = CGAffineTransform.identity
		switch imageOrientation {
		case UIImage.Orientation.down:
			transform = transform.translatedBy(x: size.width, y: size.height)
			transform = transform.rotated(by: CGFloat.pi)
			break
		case UIImage.Orientation.downMirrored:
			transform = transform.translatedBy(x: size.width, y: size.height)
			transform = transform.rotated(by: CGFloat.pi)
			break
		case UIImage.Orientation.left, UIImage.Orientation.leftMirrored:
			transform = transform.translatedBy(x: size.width, y: 0)
			transform = transform.rotated(by: CGFloat.pi/2)
			break
		case UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
			transform = transform.translatedBy(x: 0, y: size.height)
			transform = transform.rotated(by: -CGFloat.pi/2)
			break
		case UIImage.Orientation.up, UIImage.Orientation.upMirrored:
			break
		}
		
		switch imageOrientation {
		case UIImage.Orientation.upMirrored, UIImage.Orientation.downMirrored:
			transform.translatedBy(x: size.width, y: 0)
			transform.scaledBy(x: -1, y: 1)
			break
		case UIImage.Orientation.leftMirrored, UIImage.Orientation.rightMirrored:
			transform.translatedBy(x: size.height, y: 0)
			transform.scaledBy(x: -1, y: 1)
		case UIImage.Orientation.up,
				 UIImage.Orientation.down,
				 UIImage.Orientation.left,
				 UIImage.Orientation.right:
			break
		}
		
		let ctx: CGContext = CGContext(data: nil,
																	 width: Int(size.width),
																	 height: Int(size.height),
																	 bitsPerComponent: self.cgImage!.bitsPerComponent,
																	 bytesPerRow: 0,
																	 space: self.cgImage!.colorSpace!,
																	 bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
		
		ctx.concatenate(transform)
		
		switch imageOrientation {
		case UIImage.Orientation.left,
				 UIImage.Orientation.leftMirrored,
				 UIImage.Orientation.right,
				 UIImage.Orientation.rightMirrored:
			ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
		default:
			ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
			break
		}
		
		let cgImage: CGImage = ctx.makeImage()!
		
		return UIImage(cgImage: cgImage)
	}
}

extension CloseViewController: UINavigationControllerDelegate {}










