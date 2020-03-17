/// Copyright (c) 2019 Razeware LLC
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

class CardSelectionViewController: UITableViewController, CardSelectionCellDelegate {
	func navigateFromCell(to card: Card, from image: Bool, edit front: Bool) {
		if image{
			performSegue(withIdentifier: "CloseSegue", sender: card)
		} else {
			if front {
				if (tabBarController as! TabBarController).teacherMode {
					performSegue(withIdentifier: "NotesSegue", sender: card)
				}
			} else {
				performSegue(withIdentifier: "WorkbookSegue", sender: card)
			}
		}
	}
	
	
	
	
	var handleSelection: ((Card, _ selected: Bool) -> Void)!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	
	
	override func viewWillAppear(_ animated: Bool) {
//		tableView.visibleCells.forEach{
//			var cell = $0 as! CardSelectionCell
//			for cardView in cell.cardSuperView.cardViews{
//				if cardView.side == .front{
//					(cardView as! FrontCardView).updateImage()
//				}
//			}
//		}
		navigationController?.navigationBar.isHidden = true
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		tableView.visibleCells.forEach{
			let cell = $0 as! CardSelectionCell
			for cardView in cell.cardSuperView.cardViews{
				if cardView.side == .front{
					(cardView as! FrontCardView).updateImage()
				}
			}
		}
		super.viewDidAppear(animated)
	}
	
	func setCards(_ cards: [Card]){
		cellModels = cards.map(CardSelectionCell.Model.init)
		tableView.reloadData()
	}
	
	
	func propagate(emotionSelection card: Card){
		var cell = cellModels.filter{ $0.card == card}[0] as CardSelectionCell.Model
		cell.card = card
	}
	
	var cellModels: [CardSelectionCell.Model]!
	
	override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
		return cellModels.count
	}
	
	override func tableView(_: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(
			withIdentifier: "\(CardSelectionCell.self)",
			for: indexPath
			) as! CardSelectionCell
		cell.setModel(cellModels[indexPath.row])
		cell.delegate = self
		cell.cardSuperView.handleFlip = { [unowned self] destinationSide in
			self.cellModels[indexPath.row].side = destinationSide
		}
		return cell
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		var cellHeight = 2
		switch UIDevice.current.orientation{
		case .portrait:
			cellHeight = 4
		case .portraitUpsideDown:
			cellHeight = 4
		case .landscapeLeft:
			cellHeight = 2
		case .landscapeRight:
			cellHeight = 2
		default:
			cellHeight = 2
		}
		return tableView.superview!.bounds.maxY / CGFloat(cellHeight)
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		cellModels[indexPath.row].selected.toggle()
		let model = cellModels[indexPath.row]
		(tableView.cellForRow(at: indexPath) as! CardSelectionCell).setModel(model)
		handleSelection(model.card, model.selected)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender card: Any?) {
		if segue.identifier == "CloseSegue"{
			if let close = segue.destination as? CloseViewController{
				close.card = (card as! Card)
			}
		}
		if segue.identifier == "WorkbookSegue"{
			if let sheet = segue.destination as? WorksheetViewController{
				sheet.card = (card as! Card)
			}
		}
		if segue.identifier == "NotesSegue"{
			if let notes = segue.destination as? NotesTableViewController{
				notes.itemList = (card as! Card).emotion.qanda
			}
		}
	}
}
