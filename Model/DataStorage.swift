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
}

class DataStorage: DataStorageProtocol {
	var users: [User] = []
	
	var numberOfUsers: Int {
		get { return users.count }
	}
	
	init() {
		loadUsers()
	}
	
	// MARK: Private functions
	private func loadUsers() {
		
		if let url = Bundle.main.url(forResource: "users", withExtension: "json") {
			if let jsonData = try? Data(contentsOf: url) {
				let json = JSON(data: jsonData)
				for userJSON in json["users"].arrayValue {
					
					let id = userJSON["id"].intValue
					let name = userJSON["name"].stringValue
					let email = userJSON["email"].stringValue
					let avatar = userJSON["avatar"].stringValue
					
					var user = User(id: id, name: name, email: email, avatar: avatar)
					user.lastInteractions = [User: [Date]]()
					
					users.append(user)
				}
			}
		}
	}
}
