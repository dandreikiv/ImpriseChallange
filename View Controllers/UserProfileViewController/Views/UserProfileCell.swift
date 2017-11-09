//
//  UserProfileCell.swift
//  ImpriseChallenge
//
//  Created by dmytro.andreikiv@philips.com on 07/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import UIKit
import SDWebImage

class UserProfileCell: UITableViewCell {

	static let identifier = String(describing: UserProfileCell.self)
	
	@IBOutlet var profileImage: UIImageView!
	@IBOutlet var profileName: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
		
		profileImage.layer.borderWidth = 1
		profileImage.layer.cornerRadius = 4
		profileImage.layer.masksToBounds = true
		profileImage.layer.borderColor = UIColor.impriseColor.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	func update(with user: User) {
		
		profileName.text = user.name
		profileImage.image = UIImage(named: "user_placeholder")
		
		guard let url = URL(string: user.avatar) else {
			return
		}
		profileImage.sd_setImage(with: url, completed: nil)
	}
}
