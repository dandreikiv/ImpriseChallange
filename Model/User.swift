//
//  User.swift
//  ImpriseChellange
//
//  Created by dmytro.andreikiv@philips.com on 07/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import Foundation

struct User {
	var id: Int
	var name: String
	var email: String
	var avatar: String
	var lastInteractions: [User: [Date]]?
}

extension User: Hashable {
	static func ==(lhs: User, rhs: User) -> Bool {
		return lhs.id == rhs.id
	}
	
	var hashValue: Int {
		get {
			return id + name.hashValue
		}
	}
}
