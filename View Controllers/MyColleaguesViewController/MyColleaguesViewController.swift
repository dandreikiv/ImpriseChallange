//
//  MyColleaguesViewController.swift
//  ImpriseChallenge
//
//  Created by dmytro.andreikiv@philips.com on 07/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import UIKit
import DynamicColor

class MyColleaguesViewController: UIViewController {

	struct TableViewSections {
		static let NoRecentFeedbackSection = 0
		static let RecentFeedbackSection = 1
	}
	
	private let dataStorage: DataStorageProtocol
	private var tableView = UITableView()
	
	init(dataStorage: DataStorageProtocol) {
		self.dataStorage = dataStorage
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = UIColor.white
		navigationController?.navigationBar.barTintColor = UIColor.impriseColor
		
		title = NSLocalizedString("Imprise", comment: "Imprise title")
		
		tableView.dataSource = self
		tableView.delegate = self
		tableView.rowHeight = 95.0
		view.addSubview(tableView)
		
		let cellNib = UINib(nibName: String(describing: MyColleaguesTableCell.self), bundle: Bundle.main)
		tableView.register(cellNib, forCellReuseIdentifier: MyColleaguesTableCell.identifier)
		
		// Register reusable view.
		tableView.register(TableSectionsView.self, forHeaderFooterViewReuseIdentifier: TableSectionsView.identifier)
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		
		// Add reset button
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(resetDataStorage))
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		tableView.reloadData()
	}
	
	@objc private func resetDataStorage() {
		dataStorage.reset()
		tableView.reloadData()
	}
}

extension MyColleaguesViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if section == TableViewSections.NoRecentFeedbackSection {
			return dataStorage.usersWithNoRecentFeedback.count
		}
		else if section == TableViewSections.RecentFeedbackSection {
			return dataStorage.usersWithRecentFeedback.count
		}
		
		return 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return tableView.dequeueReusableCell(withIdentifier: MyColleaguesTableCell.identifier, for: indexPath)
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
}

extension MyColleaguesViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		
		guard let colleaguesCell = cell as? MyColleaguesTableCell else {
			return
		}
		
		if indexPath.section == TableViewSections.NoRecentFeedbackSection {
			let user = dataStorage.usersWithNoRecentFeedback[indexPath.row]
			configure(colleaguesCell, with: user)
		}
		else if indexPath.section == TableViewSections.RecentFeedbackSection {
			let user = dataStorage.usersWithRecentFeedback[indexPath.row]
			configure(colleaguesCell, with: user)
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		if indexPath.section == TableViewSections.NoRecentFeedbackSection {
			let user = dataStorage.usersWithNoRecentFeedback[indexPath.row]
			presentProfile(of: user)
		}
		else if indexPath.section == TableViewSections.RecentFeedbackSection {
			let user = dataStorage.usersWithRecentFeedback[indexPath.row]
			presentProfile(of: user)
		}
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let reusableView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableSectionsView.identifier)
		guard let header = reusableView as? TableSectionsView else {
			return nil
		}
		
		if section == TableViewSections.NoRecentFeedbackSection {
			header.setTitle(text: NSLocalizedString("Give them some feedback", comment: "No recent feedback section title placeholder."))
		}
		else {
			header.setTitle(text: NSLocalizedString("You gave them feedback recently", comment: "Recent feedback section title. "))
		}
		
		return header
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		
		var height: CGFloat = 34.0 // Default height
		
		if section == TableViewSections.NoRecentFeedbackSection {
			height = dataStorage.usersWithNoRecentFeedback.count == 0 ? 0.0 : height
		}
		else if section == TableViewSections.RecentFeedbackSection {
			height = dataStorage.usersWithRecentFeedback.count == 0 ? 0.0 : height
		}
		
		return height
	}
	
	private func configure(_ cell: MyColleaguesTableCell, with user: User) {
		let model = MyColleaguesCellViewModel(user: user)
		cell.updateWith(model)
		cell.delegate = self
	}
	
	private func presentProfile(of user: User) {
		let userProfileController = UserProfileViewController(user: user)
		navigationController?.pushViewController(userProfileController, animated: true)
	}
}

extension MyColleaguesViewController: MyColleaguesTableCellDelegate {
	func giveFeedback(to user: User) {
		dataStorage.addFeedback(date: Date(), to: user)
		print("Give feedback to \(user.name)")
		tableView.reloadData()
	}
}
