//
//  MyColleaguesViewController.swift
//  ImpriseChallenge
//
//  Created by dmytro.andreikiv@philips.com on 07/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import UIKit

class MyColleaguesViewController: UIViewController {

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
		tableView.dataSource = self
		tableView.delegate = self
		tableView.rowHeight = 95.0
		tableView.register(UINib(nibName: "MyColleaguesTableCell", bundle: Bundle.main), forCellReuseIdentifier: MyColleaguesTableCell.identifier)
		view.addSubview(tableView)
		
		tableView.translatesAutoresizingMaskIntoConstraints = false
		tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
		tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
		tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
		tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
		
		view.backgroundColor = UIColor.white
    }
}

extension MyColleaguesViewController: UITableViewDataSource {
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataStorage.numberOfUsers
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return tableView.dequeueReusableCell(withIdentifier: MyColleaguesTableCell.identifier, for: indexPath)
	}
}

extension MyColleaguesViewController: UITableViewDelegate {
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		if  let user = dataStorage[indexPath.row],
			let colleaguesCell = cell as? MyColleaguesTableCell {
			colleaguesCell.updateWith(user)
			colleaguesCell.delegate = self
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
}

extension MyColleaguesViewController: MyColleaguesTableCellDelegate {
	func presentProfile(of user: User) {
		
	}
}
