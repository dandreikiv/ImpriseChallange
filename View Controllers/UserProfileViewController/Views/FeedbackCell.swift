//
//  FeedbackCell.swift
//  ImpriseChallenge
//
//  Created by dmytro.andreikiv@philips.com on 07/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import UIKit

class FeedbackCell: UITableViewCell {

	static let identifier = String(describing: FeedbackCell.self)
	
	@IBOutlet var feedbackLabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	func setFeedback(text: String) {
		feedbackLabel.text = NSLocalizedString("Feedbeck sent: ", comment: "Feedback sent time format") + text
	}
}
