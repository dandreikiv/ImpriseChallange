//
//  UserProfileViewController.swift
//  ImpriseChallenge
//
//  Created by dmytro.andreikiv@philips.com on 07/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

	private let tableView = UITableView()
	
    override func viewDidLoad() {
        super.viewDidLoad()

		view.backgroundColor = UIColor.white
		
		tableView.delegate = self
		tableView.dataSource = self
		view.addSubview(tableView)
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		
		let profileCellNib = UINib(nibName: String(describing: UserProfileCell.self), bundle: Bundle.main)
		tableView.register(profileCellNib, forCellReuseIdentifier: UserProfileCell.identifier)
		
		let feedbackCellNib = UINib(nibName: String(describing: FeedbackCell.self), bundle: Bundle.main)
		tableView.register(feedbackCellNib, forCellReuseIdentifier: FeedbackCell.identifier)
    }
}

extension UserProfileViewController: UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 2
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 4
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return UITableViewCell()
	}
}

extension UserProfileViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		
	}
}
