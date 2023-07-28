//
//  AppDelegate.swift
//  NewYorkTimesViper
//
//  Created by Viacheslav Markov on 18.07.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    lazy var window: UIWindow? = .init(frame: UIScreen.main.bounds)

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {

        showCategoryViewController()

        return true
    }
}

// MARK: - AppDelegate
private extension AppDelegate {
    func showCategoryViewController() {
        let vc = CategoryModuleBuilder.build()
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.tintColor = .black
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }
}
