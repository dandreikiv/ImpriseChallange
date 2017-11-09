//
//  FeedbackCellModel.swift
//  ImpriseChallenge
//
//  Created by dmytro.andreikiv@philips.com on 09/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import Foundation

class FeedbackCellModel {
	
	var attributedString: NSAttributedString?
	
	init (date: Date) {
		
		let timeDifference = date.timeDifference
		
		switch timeDifference {
		case .undefined:
			attributedString = NSAttributedString(string: timeDifference.stringValue())
			
		default:
			let timeString = timeDifference.stringValue().lowercased()
			
			let format = NSLocalizedString("Feedback sent: %@", comment: "Last feedback placeholder")
			let feedback = String(format: format, timeString)
			
			let range = feedback.range(of: timeString)
			let feedbackAttributedString = NSMutableAttributedString(string: feedback)
			
			feedbackAttributedString.setAttributes(
				[NSAttributedStringKey.foregroundColor: timeDifference.colorValue()],
				range: NSRange(range!, in: feedback)
			)
			
			attributedString = feedbackAttributedString
		}
	}
}
