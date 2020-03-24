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

class LessonViewController: UIViewController, LongDelegate{
	
	deinit {
		NotificationCenter.default.removeObserver(self)
	}
	
	@IBAction func instructionsButton(_ sender: UIButton) {
		performSegue(withIdentifier: "InstructionsSegue", sender: nil)
	}
	func navigate(to card: Card, from image: Bool, edit front: Bool) {
		if image{
			performSegue(withIdentifier: "CloseSegue", sender: card)
		} else {
			breakStreak()
			performSegue(withIdentifier: "PDFSegue", sender: card)
		}
	}
	
	var landscapeBackCardConstraint: NSLayoutConstraint!
	@IBOutlet var widthRatio: NSLayoutConstraint!
	@IBOutlet var mainStack: UIStackView!
	@IBOutlet var celebrationView: CelebrationView!
	@IBOutlet var streakBrokenView: UIView!
	@IBOutlet var streakBrokenLabel: UILabel!
	@IBOutlet var streakBrokenLabel2: UILabel!
	@IBOutlet var stackView: UIStackView!
	@IBOutlet var stackViewHeightConstraint: NSLayoutConstraint!
	@IBOutlet var multipleChoiceSuperview: UIView!
	@IBAction func instructionButton(_ sender: UIButton) {
		performSegue(withIdentifier: "InstructionsSegue", sender: nil)
	}
	
	@IBOutlet var cardSuperview: CardSuperview! {
		didSet {
			cardSuperview.longDelegate = self
			cardSuperview.handleFlip = { [unowned self] _ in self.breakStreak() }
		}
	}
	
	@IBAction func handleTryAgainTap() {
		pickNewCard()
		animateOut(view: streakBrokenView)
	}
	
	var cards: [Card]!
	
	var streakCount = 0 {
		didSet {
			celebrationView.streakStackView.isHidden = streakCount < 2
			celebrationView.streakLabel.text = String(streakCount)
		}
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		for cardView in cardSuperview.cardViews{
			if cardView.side == .front{
				(cardView as! FrontCardView).updateImage()
			}
		}
	}
	
	override func viewWillAppear(_ animated: Bool) {
		navigationController?.navigationBar.isHidden = true
	}
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		
		if UIDevice.current.userInterfaceIdiom == .pad && UIDevice.current.orientation.isLandscape{
			mainStack.axis = .horizontal
		}
	}
	override func viewDidLoad() {
		view.addSubview(
			celebrationView,
			constrainedTo: stackView, widthAnchorView: cardSuperview,
			multiplier: 1 / stackViewHeightConstraint.multiplier
		)
		view.addSubview(streakBrokenView, constrainedTo: multipleChoiceSuperview)
		for view: UIView in [cardSuperview, multipleChoiceSuperview] {
			view.isExclusiveTouch = true
		}
		pickNewCard()
				NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: UIDevice.orientationDidChangeNotification, object: nil)
		
//		let cardBack = cardSuperview.cardViews.filter{ $0.side == CardView.Side.back}[0] as CardView
//		landscapeBackCardConstraint = cardBack.heightAnchor.constraint(equalTo: mainStack.heightAnchor)
//		landscapeBackCardConstraint.isActive = false
	}
	
	override func shouldPerformSegue(withIdentifier: String, sender: Any?) -> Bool {
		return sender is Card || withIdentifier == "CloseSegue"
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender correctCard: Any?) {
//		widthRatio.isActive = false
//		landscapeBackCardConstraint = NSLayoutConstraint()
		if segue.identifier == "CloseSegue"{
			if let close = segue.destination as? CloseViewController{
				close.card = (correctCard as! Card)
			}
		}
		if segue.identifier == "PDFSegue"{
			if let pdf = segue.destination as? PDFViewController{
				pdf.job = .InfoSheet
				pdf.card = (correctCard as! Card)
			}
		}
		
		if let namesViewController = segue.destination as? LessonNamesViewController {
			namesViewController.cards = cards
			namesViewController.correctCard = (correctCard as! Card)
			namesViewController.delegate = self
		}
	}
	
	func pickNewCard() {
		cardSuperview.learnTime = false
		streakBrokenLabel.isHidden = false
		streakBrokenLabel2.isHidden = false
		let side = CardView.Side.allCases.randomElement()!
		let correctCard = cards.randomElement()!
		switch side {
		case .front:
			performSegue(withIdentifier: "NamesSegue", sender: correctCard)
		case .back:
			let imagesViewController = UIStoryboard(
				name: "\(LessonImagesViewController.self)",
				bundle: nil
				).instantiateInitialViewController() as! LessonImagesViewController
			imagesViewController.cards = cards
			imagesViewController.correctCard = correctCard
			imagesViewController.delegate = self
			imagesViewController.longDelegate = self
			addChild(imagesViewController)
			multipleChoiceSuperview.addSubview(
				imagesViewController.view,
				constrainedTo: multipleChoiceSuperview
			)
			imagesViewController.didMove(toParent: self)
		}
		cardSuperview.setCard(correctCard, side: side, flip: true)
		cardSuperview.isUserInteractionEnabled = true
	}
	
	func breakStreak() {
		print("breakStreak")
		streakBrokenLabel.text = "\(streakCount)"
		streakCount = 0
		//        cardSuperview.isUserInteractionEnabled = false
		streakBrokenView.animateIn()
		removeMultipleChoiceView()
		cardSuperview.learnTime = true
	}
	
	func animateOut(
		view: UIView,
		delay: TimeInterval = 0,
		handleCompletion: ( () -> Void )? = nil) {
		
		UIView.animate(
			withDuration: 0.25,
			delay: delay,
			animations: {
				view.alpha = 0
				view.transform = CGAffineTransform.identity.scaledBy(x: 0.1, y: 0.1)
		}
		) {
			[ handleCompletion = handleCompletion ?? { view.isHidden = true } ]
			_ in handleCompletion()
		}
	}
	
	func removeMultipleChoiceView() {
		if !cardSuperview.learnTime{
			streakBrokenLabel.isHidden = false
			streakBrokenLabel2.isHidden = false
			let multipleChoiceView = multipleChoiceSuperview.subviews[0]
			let childController = children.first { $0.view == multipleChoiceView }!
			animateOut(view: multipleChoiceView) {
				childController.removeFromParent()
				multipleChoiceView.removeFromSuperview()
			}
		}else{
			streakBrokenLabel.isHidden = true
			streakBrokenLabel2.isHidden = true
		}
	}
}

extension LessonViewController: MultipleChoiceViewControllerDelegate {
	func handleCardControlTapped(correct: Bool) {
		if correct {
			streakCount += 1
			removeMultipleChoiceView()
			celebrationView.animateIn(handleCompletion: pickNewCard)
			animateOut(view: celebrationView, delay: 0.6)
		}
		else {
			cardSuperview.flipCard()
			breakStreak()
		}
	}
	
	func fillBackCardHieightInLAndscape(){
		let cardBack = cardSuperview.cardViews.filter{ $0.side == CardView.Side.back}[0] as CardView
		if !cardBack.isHidden{
		}
	}
	
	@objc func rotated() {
		if UIDevice.current.userInterfaceIdiom == .pad && UIDevice.current.orientation.isLandscape{
			mainStack.axis = .horizontal
		} else {
			if self.view.frame.height > self.view.frame.width {
			mainStack.axis = .vertical
			}
		}
	}
}
