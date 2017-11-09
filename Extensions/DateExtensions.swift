//
//  DateExtensions.swift
//  ImpriseChallenge
//
//  Created by dmytro.andreikiv@philips.com on 08/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import Foundation
import UIKit

enum TimeDifference {
	case seconds(Int)
	case minutes(Int)
	case hours(Int)
	case days(Int)
	case weeks(Int)
	case month(Int)
	case years(Int)
	case undefined
}

extension Date {
	
	/// Returns the gratest difference between the date and current moment of time.
	/// If the difference between two dates is 1 year 5 month and 1 day, the 1 year
	/// will be returned as result.
	var timeDifference: TimeDifference {
		get {
			let dateComponents: Set<Calendar.Component> = [ .second, .minute, .hour, .day, .weekOfYear, .month, .year ]
			let components = Calendar.current.dateComponents(dateComponents, from: self, to: Date())
			
			let yearsDiff = components.year ?? 0
			if yearsDiff > 0 {
				return .years(yearsDiff)
			}
			
			let monthsDiff = components.month ?? 0
			if monthsDiff > 0 {
				return .month(monthsDiff)
			}
			
			let weeksDiff = components.weekOfYear ?? 0
			if weeksDiff > 0 {
				return .weeks(weeksDiff)
			}
			
			let daysDiff = components.day ?? 0
			if daysDiff > 0 {
				return .days(daysDiff)
			}
			
			let hoursDiff = components.hour ?? 0
			if hoursDiff > 0 {
				return .hours(hoursDiff)
			}
			
			let minutesDiff = components.minute ?? 0
			if minutesDiff > 0{
				return .minutes(minutesDiff)
			}
			
			let secondsDiff = components.second ?? 0
			if secondsDiff >= 0 {
				return .seconds(secondsDiff)
			}
			
			return .undefined
		}
	}
	
	func components(components: Set<Calendar.Component>, to date: Date) -> DateComponents {
		return Calendar.current.dateComponents(components, from: self, to: date)
	}
	
	func date(byAdding components: DateComponents) -> Date? {
		return Calendar.current.date(byAdding: components, to: self)
	}
}

extension TimeDifference {
	
	func stringValue() -> String {
		switch self {
		case .seconds(_):
			return NSLocalizedString("Just now", comment: "Just now format")
			
		case .minutes(let diff):
			let minutesFormat = NSLocalizedString("%d minutes ago", comment: "Number of minutes ago")
			return String(format: minutesFormat, diff)
			
		case .hours(let diff):
			let hoursFormat = NSLocalizedString("%d hours ago", comment: "Number of hours ago")
			return String(format: hoursFormat, diff)
			
		case .days(let diff):
			let daysFormat = NSLocalizedString("%d days ago", comment: "Number of days ago")
			return String(format: daysFormat, diff)
		
		case .weeks(let diff):
			let weeksFormat = NSLocalizedString("%d weeks ago", comment: "Number of weeks ago")
			return String(format: weeksFormat, diff)
			
		case .month(let diff):
			let monthFormat = NSLocalizedString("%d month ago", comment: "Number of months ago")
			return String(format: monthFormat, diff)
			
		case .years(let diff):
			let yearsFormat = NSLocalizedString("%d years ago", comment: "Number of years ago")
			return String(format: yearsFormat, diff)
			
		default:
			return NSLocalizedString("You haven't given a feedback yet", comment: "Feedback not given placeholder")
		}
	}
	
	func colorValue() -> UIColor {
		switch self {
		case .seconds(_), .minutes(_), .hours(_), .days(_):
			return UIColor.black
			
		case .weeks(let diff):
			return diff < 2 ? UIColor.black : UIColor.impriseColor
			
		default:
			return UIColor.red
		}
	}
}
