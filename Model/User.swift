//
//  User.swift
//  ImpriseChellange
//
//  Created by dmytro.andreikiv@philips.com on 07/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import Foundation

class User {
	var id: Int
	var name: String
	var email: String
	var avatar: String
	var lastInteractions: [Date]?
	
	init(id: Int, name: String, email: String, avatar: String, lastInteractions: [Date]? = nil) {
		self.id = id
		self.name = name
		self.email = email
		self.avatar = avatar
		self.lastInteractions = lastInteractions
	}
	
	func addInteraction(date: Date) {
		lastInteractions?.append(date)
	}
}

extension User: Hashable {
	static func ==(lhs: User, rhs: User) -> Bool {
		return lhs.id == rhs.id && lhs.hashValue == rhs.hashValue
	}
	
	var hashValue: Int {
		get {
			return id + name.hashValue
		}
	}
}

extension User {
	var firstName: String? {
		get {
			return name.components(separatedBy: CharacterSet.whitespacesAndNewlines).first
		}
	}
	
	var lastName: String? {
		get {
			return name.components(separatedBy: CharacterSet.whitespacesAndNewlines).last
		}
	}
	
	var hasRecentFeedback: Bool {
		
		// There is no recent feedback if the lastInteractions array is empty.
		guard let interaction = lastInteractions?.sorted(by: {$0 > $1}).first else {
			return false
		}

		let components = interaction.components(components: [.weekOfYear], to: Date())
		guard let numberOfWeesk = components.weekOfYear else {
			return false
		}
		
		return numberOfWeesk < 2
	}
}
