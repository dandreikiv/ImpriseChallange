//
//  AppDelegate.swift
//  ImpriseChellange
//
//  Created by dmytro.andreikiv@philips.com on 07/11/2017.
//  Copyright © 2017 Dmytro Andreikiv. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		window = UIWindow(frame: UIScreen.main.bounds)

		configureUI()
		
		let controller = MyColleaguesViewController(dataStorage: DataStorage())
		let navController = UINavigationController(rootViewController: controller)
		
		window?.rootViewController = navController
		
		window?.makeKeyAndVisible()
		// Override point for customization after application launch.
		return true
	}
	
	private func configureUI() {
		let titleFontSize: CGFloat = 24
		
		UINavigationBar.appearance().tintColor = UIColor.white
		UINavigationBar.appearance().titleTextAttributes = [
			NSAttributedStringKey.foregroundColor: UIColor.white,
			NSAttributedStringKey.font: UIFont(name: "HelveticaNeue-Medium", size: titleFontSize) ?? UIFont.systemFont(ofSize: titleFontSize)
		]
		
		UIApplication.shared.statusBarStyle = .lightContent
	}
}

