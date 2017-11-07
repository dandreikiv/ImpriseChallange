//
//  MyColleaguesTableCellDelegate.swift
//  ImpriseChallenge
//
//  Created by dmytro.andreikiv@philips.com on 07/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import Foundation

protocol MyColleaguesTableCellDelegate: class {
	func giveFeedback(to user: User)
}
