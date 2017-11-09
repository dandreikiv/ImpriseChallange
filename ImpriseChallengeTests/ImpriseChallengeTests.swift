//
//  ImpriseChellangeTests.swift
//  ImpriseChellangeTests
//
//  Created by dmytro.andreikiv@philips.com on 07/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import XCTest
@testable import ImpriseChallenge

class ImpriseChellangeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSecondsAgoString() {
		let date = Date()
		var components = DateComponents()
		
		let seconds = 30
		components.setValue(-seconds, for: Calendar.Component.second)
		let expectedString = NSLocalizedString("Just now", comment: "Just now format")
		if let newDate = Calendar.current.date(byAdding: components, to: date) {
			XCTAssertEqual(newDate.timeDifference.stringValue(), expectedString)
		}
    }
	
	func testMinutesAgoString() {
		let date = Date()
		var components = DateComponents()
		
		let minutes = 30
		components.setValue(-minutes, for: Calendar.Component.minute)
		
		let minutesFormat = NSLocalizedString("%d minutes ago", comment: "Number of minutes ago")
		let expectedString = String(format: minutesFormat, minutes)
		
		if let newDate = Calendar.current.date(byAdding: components, to: date) {
			XCTAssertEqual(newDate.timeDifference.stringValue(), expectedString)
		}
	}
	
	func testHoursAgoString() {
		let date = Date()
		var components = DateComponents()
		
		let hours = 3
		components.setValue(-hours, for: Calendar.Component.hour)
		
		let hoursFormat = NSLocalizedString("%d hours ago", comment: "Number of hours ago")
		let expectedString = String(format: hoursFormat, hours)
		
		if let newDate = Calendar.current.date(byAdding: components, to: date) {
			XCTAssertEqual(newDate.timeDifference.stringValue(), expectedString)
		}
	}
	
	func testDaysAgoString() {
		let date = Date()
		var components = DateComponents()
		
		let days = 3
		components.setValue(-days, for: Calendar.Component.day)
		
		let daysFormat = NSLocalizedString("%d days ago", comment: "Number of days ago")
		let expectedString = String(format: daysFormat, days)
		
		if let newDate = Calendar.current.date(byAdding: components, to: date) {
			XCTAssertEqual(newDate.timeDifference.stringValue(), expectedString)
		}
	}
	
	func testMonthAgoString() {
		let date = Date()
		var components = DateComponents()
		
		let month = 3
		components.setValue(-month, for: Calendar.Component.month)
		
		let monthFormat = NSLocalizedString("%d month ago", comment: "Number of months ago")
		let expectedString = String(format: monthFormat, month)
		
		if let newDate = Calendar.current.date(byAdding: components, to: date) {
			XCTAssertEqual(newDate.timeDifference.stringValue(), expectedString)
		}
	}
	
	func testYearsAgoString() {
		let date = Date()
		var components = DateComponents()
		
		let years = 3
		components.setValue(-years, for: Calendar.Component.year)
		
		let yearsFormat = NSLocalizedString("%d years ago", comment: "Number of years ago")
		let expectedString = String(format: yearsFormat, years)
		
		if let newDate = Calendar.current.date(byAdding: components, to: date) {
			XCTAssertEqual(newDate.timeDifference.stringValue(), expectedString)
		}
	}
	
	func testPopertyReturnsTheLatestDateString() {
		let date = Date()
		var components = DateComponents()
		
		let years = 3
		components.setValue(-years, for: Calendar.Component.year)
		components.setValue(-10, for: Calendar.Component.month)
		components.setValue(-4, for: Calendar.Component.day)
		components.setValue(-5, for: Calendar.Component.hour)
		
		let yearsFormat = NSLocalizedString("%d years ago", comment: "Number of years ago")
		let expectedString = String(format: yearsFormat, years)
		
		if let newDate = Calendar.current.date(byAdding: components, to: date) {
			XCTAssertEqual(newDate.timeDifference.stringValue(), expectedString)
		}
	}
	
	func testDataStorageRetursUsersWithRecentFeedback() {
		
		class TestDataStorage: DataStorage {
			override var users: [User] {
				get {
					let user1 = User(id: 0, name: "User1 Name1", email: "email1", avatar: "avatar1")
					user1.lastInteractions = [Date()]
					
					let user2 = User(id: 1, name: "User2 Name2", email: "email2", avatar: "avatar2")
					user2.lastInteractions = [Date().date(byAdding: DateComponents(day: -24))!]
					
					return [user1, user2]
				}
				set {}
			}
		}
		
		let dataStorage: DataStorageProtocol = TestDataStorage()
		print(dataStorage.numberOfUsers)
		XCTAssertEqual(dataStorage.usersWithRecentFeedback.count, 1)
	}
}
