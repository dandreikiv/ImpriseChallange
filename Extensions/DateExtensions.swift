//
//  DateExtensions.swift
//  ImpriseChallenge
//
//  Created by dmytro.andreikiv@philips.com on 08/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import Foundation

extension Date {
	
	var timeFromNow: String {
		get {
			let dateComponents: Set<Calendar.Component> = [ .second, .minute, .hour, .day, .month, .year ]
			let components = Calendar.current.dateComponents(dateComponents, from: self, to: Date())
		
			let years = components.year ?? 0
			if years > 0 {
				let yearsFormat = NSLocalizedString("%d years ago", comment: "Number of years ago")
				return String(format: yearsFormat, years)
			}
			
			let months = components.month ?? 0
			if months > 0 {
				let monthFormat = NSLocalizedString("%d month ago", comment: "Number of months ago")
				return String(format: monthFormat, months)
			}
			
			let days = components.day ?? 0
			if days > 0 {
				let daysFormat = NSLocalizedString("%d days ago", comment: "Number of days ago")
				return String(format: daysFormat, days)
			}
			
			let hours = components.hour ?? 0
			if hours > 0 {
				let hoursFormat = NSLocalizedString("%d hours ago", comment: "Number of hours ago")
				return String(format: hoursFormat, hours)
			}
			
			let minutes = components.minute ?? 0
			if minutes > 0{
				let minutesFormat = NSLocalizedString("%d minutes ago", comment: "Number of minutes ago")
				return String(format: minutesFormat, minutes)
			}
			
			let seconds = components.second ?? 0
			if seconds >= 0 {
				return NSLocalizedString("Just now", comment: "Just now format")
			}
			
			return NSLocalizedString("You haven't given a feedback yet", comment: "Feedback not given placeholder")
		}
	}
	
	func components(components: Set<Calendar.Component>, to date: Date) -> DateComponents {
		return Calendar.current.dateComponents(components, from: self, to: date)
	}
	
	func date(byAdding components: DateComponents) -> Date? {
		return Calendar.current.date(byAdding: components, to: self)
	}
}
