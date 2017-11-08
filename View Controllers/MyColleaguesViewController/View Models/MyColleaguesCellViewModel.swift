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
	var lastGivenFeedback: NSAttributedString
	
	let user: User
	
	init(user: User) {
		self.user = user
		
		firstName = self.user.firstName
		lastName = self.user.lastName
		
		guard let lastFeedbackDateString = self.user.lastInteractions?.first?.timeFromNow.lowercased() else {
			let noFeedbackYet = NSLocalizedString("You haven't given feedback yet", comment: "Haven't given feedback placeholder")
			lastGivenFeedback = NSAttributedString(string: noFeedbackYet)
			return
		}
		
		let lastFeedbackFormat = NSLocalizedString("Last feedback you sent: %@", comment: "Last feedback placeholder")
		let feedbackString = String(format: lastFeedbackFormat, lastFeedbackDateString)
		
		let range = feedbackString.range(of: lastFeedbackDateString)
		let mutableFeedbackString = NSMutableAttributedString(string: feedbackString)
		
		mutableFeedbackString.setAttributes(
			[NSAttributedStringKey.foregroundColor: UIColor.red], range: NSRange(range!, in: feedbackString))

		lastGivenFeedback = mutableFeedbackString
	}
}
