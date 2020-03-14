//
//  ItemListTableViewCell.swift
//  WML
//
//  Created by Donald Fletcher on 23/01/2020.
//  Copyright © 2020 Donald Fletcher. All rights reserved.
//

import UIKit

class ItemListTableViewCell: UITableViewCell {

	@IBOutlet var itemListTextLabel: UILabel!
	@IBOutlet var checkMarkLabel: UILabel!
	override func awakeFromNib() {
        super.awakeFromNib()
				selectionStyle = .blue
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
