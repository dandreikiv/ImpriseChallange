//
//  UserProfileViewController.swift
//  ImpriseChallenge
//
//  Created by dmytro.andreikiv@philips.com on 07/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

	struct UserProfileTable{
		static let ImageSection: Int = 0
		static let FeedbackSection: Int = 1
	}
	
	struct TableViewDimensions {
		static let ImageCellHeight: CGFloat = 130.0
		static let FeedbackCellHeight: CGFloat = 40.0
		static let NoFeedbackCellHeight: CGFloat = 130
		static let SectionHeaderHeight: CGFloat = 34
	}
	
	private let user: User
	private let feedbackInteractions: [Date]
	private let tableView = UITableView()
	private let sectionCellIdentifiers = [UserProfileCell.identifier, FeedbackCell.identifier]
	
	init(user: User) {
		self.user = user
		self.feedbackInteractions = user.lastInteractions ?? []
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = UIColor.white
		
		tableView.delegate = self
		tableView.dataSource = self
		view.addSubview(tableView)
		
		// Layout table veiw.
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		
		// Register cells.
		let profileCellNib = UINib(nibName: String(describing: UserProfileCell.self), bundle: Bundle.main)
		tableView.register(profileCellNib, forCellReuseIdentifier: UserProfileCell.identifier)
		
		let feedbackCellNib = UINib(nibName: String(describing: FeedbackCell.self), bundle: Bundle.main)
		tableView.register(feedbackCellNib, forCellReuseIdentifier: FeedbackCell.identifier)
		
		let noFeedbackCellNib = UINib(nibName: String(describing: NoFeedbackCell.self), bundle: Bundle.main)
		tableView.register(noFeedbackCellNib, forCellReuseIdentifier: NoFeedbackCell.identifier)
		
		// Register reusable view.
		tableView.register(TableSectionsView.self, forHeaderFooterViewReuseIdentifier: TableSectionsView.identifier)
    }
}

extension UserProfileViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return sectionCellIdentifiers.count
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		if section == UserProfileTable.ImageSection {
			return 1
		}
		
		guard let count = self.user.lastInteractions?.count else {
			return 1
		}
		
		return count == 0 ? 1 : count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if indexPath.section == UserProfileTable.ImageSection {
			return tableView.dequeueReusableCell(withIdentifier: UserProfileCell.identifier, for: indexPath)
		}
		
		if let interactions = self.user.lastInteractions, interactions.count > 0 {
			return tableView.dequeueReusableCell(withIdentifier: FeedbackCell.identifier, for: indexPath)
		}
		
		return tableView.dequeueReusableCell(withIdentifier: NoFeedbackCell.identifier, for: indexPath)
	}
}

extension UserProfileViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if indexPath.section == UserProfileTable.ImageSection {
			guard let imageCell = cell as? UserProfileCell else {
				return
			}
			imageCell.update(with: user)
		}
		else if indexPath.section == UserProfileTable.FeedbackSection {
			guard let feedbackCell = cell as? FeedbackCell else {
				return
			}
			
			guard let feedbackInteraction = user.lastInteractions?[indexPath.row] else {
				return
			}
			
			feedbackCell.setFeedback(model: FeedbackCellModel(date: feedbackInteraction))
		}
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		if section == UserProfileTable.ImageSection {
			return nil
		}
		
		let reusableView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableSectionsView.identifier)
		guard let header = reusableView as? TableSectionsView else {
			return nil
		}
		
		let headerTitle = NSLocalizedString("Feedback given to ", comment: "Feedback section title")
		let userName = user.firstName ?? NSLocalizedString("User", comment: "User name placeholder")
		header.setTitle(text: headerTitle + userName + ":")
		
		return header
	}
	
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		if section == UserProfileTable.ImageSection {
			return 0.0
		}
		return TableViewDimensions.SectionHeaderHeight
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		if indexPath.section == UserProfileTable.ImageSection {
			return TableViewDimensions.ImageCellHeight
		}
		
		let interactionsCount = self.user.lastInteractions?.count ?? 0
		return interactionsCount == 0 ? TableViewDimensions.NoFeedbackCellHeight : TableViewDimensions.FeedbackCellHeight
	}
}
