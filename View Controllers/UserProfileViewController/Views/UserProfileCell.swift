//
//  UserProfileCell.swift
//  ImpriseChallenge
//
//  Created by dmytro.andreikiv@philips.com on 07/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import UIKit

class UserProfileCell: UITableViewCell {

	static let identifier = String(describing: UserProfileCell.self)
	
	@IBOutlet var profileImage: UIImageView!
	@IBOutlet var profileName: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
