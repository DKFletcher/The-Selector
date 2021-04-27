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

protocol CardSelectionCellDelegate{
	func navigateFromCell(to card: Card, from image: Bool, edit front : Bool)
}
class CardSelectionCell: UITableViewCell, LongDelegate, CardSelectionCellDelegate {
    func navigateFromCell(to card: Card, from image: Bool, edit front: Bool) {
        delegate?.navigateFromCell(to: card, from: image, edit: front)
    }
    
    func navigate(to card: Card, from image: Bool, edit front: Bool) {
        navigateFromCell(to: card, from: image, edit: front)
    }
    

    var delegate :  CardSelectionCellDelegate?
    
    struct Model: Hashable {
        var card: Card
        var side: CardView.Side = .front
        var selected = true
        
        init(card: Card){
            self.card = card
        }
        
        init(card: Card, side: CardView.Side, selected: Bool){
            self.card=card
            self.side=side
            self.selected=selected
        }
        
        static func == (lhs: Model, rhs: Model) -> Bool {
            return lhs.card == rhs.card && lhs.side == rhs.side && lhs.selected == rhs.selected
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(card)
            hasher.combine(side)
            hasher.combine(selected)
        }
    }
    var model : Model!
    
    @IBOutlet var emotionImage: UIImageView!
    
    @IBOutlet weak var emotionNameLabel: UILabel!
    @objc func emotionTapped(_ sender: Any){
        print("zone: \(model.card.emotion.index.zone.rawValue)")
        navigate(to: model.card, from: true, edit: false)
    }
    func updateImage(){
        emotionImage.image = imageServer.get(image: model.card)
    }
	func setModel(_ model: Model) {
		self.model = model
        emotionNameLabel.text=model.card.name
        emotionImage.image = imageServer.get(image: model.card)
        let pictureTap = UITapGestureRecognizer(target: self, action: #selector(emotionTapped))
        emotionImage.isUserInteractionEnabled = true
        emotionImage.addGestureRecognizer(pictureTap)
        accessoryType = model.selected ? .checkmark : .none
	}
	
	
	func getModel() -> Model{
		return model
	}
}

