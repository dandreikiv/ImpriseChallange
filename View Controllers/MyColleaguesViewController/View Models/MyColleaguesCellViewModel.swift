//
//  MyColleaguesCellViewModel.swift
//  ImpriseChallenge
//
//  Created by dmytro.andreikiv@philips.com on 08/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import Foundation
import UIKit

class MyColleaguesCellViewModel {
	
	var firstName: String?
	var lastName: String?
	var lastGivenFeedback: NSAttributedString?
	
	let user: User
	
	init(user: User) {
		self.user = user
		
		firstName = self.user.firstName
		lastName = self.user.lastName
		
		let timeDifference = self.user.lastInteractions?.first?.timeDifference ?? .undefined
		
		switch timeDifference {
		case .undefined:
			lastGivenFeedback = NSAttributedString(string: timeDifference.stringValue())
			
		default:
			let timeString = timeDifference.stringValue().lowercased()
			
			let format = NSLocalizedString("Last feedback you sent: %@", comment: "Last feedback placeholder")
			let feedback = String(format: format, timeString)
			
			let range = feedback.range(of: timeString)
			let feedbackAttributedString = NSMutableAttributedString(string: feedback)
			
			feedbackAttributedString.setAttributes(
				[NSAttributedStringKey.foregroundColor: timeDifference.colorValue()],
				range: NSRange(range!, in: feedback)
			)
			
			lastGivenFeedback = feedbackAttributedString
		}
	}
}
