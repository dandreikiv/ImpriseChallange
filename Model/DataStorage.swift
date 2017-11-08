//
//  DataStorage.swift
//  ImpriseChellange
//
//  Created by dmytro.andreikiv@philips.com on 07/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol DataStorageProtocol: class {
	var users: [User] { get }
	var numberOfUsers: Int { get }
	var usersWithNoRecentFeedback: [User] { get }
	var usersWithRecentFeedback: [User] { get }
	subscript(index: Int) -> User? { get }
	
	func addFeedback(date: Date, to user: User)
	func reset()
}

class DataStorage: DataStorageProtocol {
	var users: [User] = []
	private let dateFormatter = DateFormatter()
	
	var numberOfUsers: Int {
		get { return users.count }
	}
	
	init() {
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
		loadUsers()
	}
	
	subscript(index: Int) -> User? {
		get {
			if index < users.count {
				return users[index]
			}
			return nil
		}
	}
	
	var usersWithRecentFeedback: [User] {
		return users.filter { (user) -> Bool in
			return user.hasRecentFeedback
		}
	}
	
	var usersWithNoRecentFeedback: [User] {
		return users.filter { (user) -> Bool in
			return user.hasRecentFeedback == false
		}
	}
	
	func addFeedback(date: Date, to user: User) {
		user.addInteraction(date: date)
		user.lastInteractions?.sort(by: { $0 > $1 })
	}
	
	func reset() {
		loadUsers()
	}
	
	// MARK: Private functions
	private func loadUsers() {
		guard let url = Bundle.main.url(forResource: "users", withExtension: "json") else {
			return
		}
		
		guard let jsonData = try? Data(contentsOf: url) else {
			return
		}
		
		users.removeAll()
		
		let json = JSON(data: jsonData)
		for userJSON in json["users"].arrayValue {
			
			let id = userJSON["id"].intValue
			let name = userJSON["name"].stringValue
			let email = userJSON["email"].stringValue
			let avatar = userJSON["avatar"].stringValue
			
			var interactions = userJSON["last_interactions"].arrayValue.flatMap({(interaction) -> Date? in
				return dateFormatter.date(from: interaction["date"].stringValue)
			})
			interactions.sort(by: { $0 > $1 })
			
			let user = User(id: id, name: name, email: email, avatar: avatar)
			user.lastInteractions = interactions
			users.append(user)
		}
	}
}
