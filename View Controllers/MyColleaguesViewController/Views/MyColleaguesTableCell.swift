//
//  MyColleaguesTableCell.swift
//  ImpriseChallenge
//
//  Created by dmytro.andreikiv@philips.com on 07/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import UIKit
import SDWebImage
import DynamicColor

class MyColleaguesTableCell: UITableViewCell {
	
	@IBOutlet var avatar: UIImageView!
	@IBOutlet var userName: UILabel!
	@IBOutlet var lastFeedback: UILabel!
	
	static let identifier = String(describing: MyColleaguesTableCell.self)
	
	weak var delegate: MyColleaguesTableCellDelegate?
	var model: MyColleaguesCellViewModel?
	
    override func awakeFromNib() {
        super.awakeFromNib()
		
		selectionStyle = .none
 
		avatar.layer.borderWidth = 1.0
		avatar.layer.cornerRadius = 4.0
		avatar.layer.masksToBounds = true
		avatar.layer.borderColor = UIColor.yellow.mixed(withColor: DynamicColor.red).cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func updateWith(_ model: MyColleaguesCellViewModel?) {
		self.model = model
		userName.text = model?.user.name
		lastFeedback.attributedText = model?.lastGivenFeedback
		
		guard let avatarPath = model?.user.avatar else {
			return
		}
		
		guard let url = URL(string: avatarPath) else {
			return
		}
		
		avatar.sd_setImage(with: url , completed: nil)
	}
    
	@IBAction func giveFeedbackPressed(_ sender: Any) {
		if let user = model?.user {
			delegate?.giveFeedback(to: user)
		}
	}
}
