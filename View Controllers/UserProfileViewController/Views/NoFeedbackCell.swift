//
//  NoFeedbackCell.swift
//  ImpriseChallenge
//
//  Created by dmytro.andreikiv@philips.com on 09/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import UIKit

class NoFeedbackCell: UITableViewCell {

	static let identifier = String(describing: NoFeedbackCell.self)
	
	@IBOutlet var title: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        title.text = NSLocalizedString("No feedback had been sent yet.", comment: "No feedback placeholder")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
