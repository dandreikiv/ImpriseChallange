//
//  TableSectionsView.swift
//  ImpriseChallenge
//
//  Created by dmytro.andreikiv@philips.com on 07/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import UIKit
import DynamicColor

class TableSectionsView: UITableViewHeaderFooterView {
	
	static let identifier = String(describing: TableSectionsView.self)
	
	private let title = UILabel()
	
	override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		contentView.addSubview(title)
		
		title.font = UIFont(name: "HelveticaNeue-Light", size: 18)
		
		title.translatesAutoresizingMaskIntoConstraints = false
		title.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16.0).isActive = true
		title.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
		title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
		title.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 12.0).isActive = true
		
		title.text = "Header text"
		title.textColor = UIColor.white
		contentView.backgroundColor = UIColor.yellow.mixed(withColor: UIColor.red)
	}
	
	func setTitle(text: String?) {
		title.text = text
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
}
