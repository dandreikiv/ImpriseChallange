//
//  MyColleaguesTableCell.swift
//  ImpriseChallenge
//
//  Created by dmytro.andreikiv@philips.com on 07/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import UIKit

class MyColleaguesTableCell: UITableViewCell {
	
	@IBOutlet var avatar: UIImageView!
	@IBOutlet var userName: UILabel!
	@IBOutlet var lastFeedback: UILabel!
	
	static let identifier = String(describing: MyColleaguesTableCell.self)
	
	weak var delegate: MyColleaguesTableCellDelegate?
	var user: User?
	
    override func awakeFromNib() {
        super.awakeFromNib()
		
		avatar.layer.borderWidth = 1.0
		avatar.layer.cornerRadius = 4.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func updateWith(_ user: User) {
		self.user = user
		userName.text = user.name
	}
    
	@IBAction func giveFeedbackPressed(_ sender: Any) {
		if let user = user {
			delegate?.giveFeedback(to: user)
		}
	}
}
