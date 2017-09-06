//
//  AppDelegate.swift
//  VideoPlayer
//
//  Created by 楊采庭 on 2017/9/6.
//  Copyright © 2017年 楊采庭. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        let mainViewController = MainViewController()

        window!.rootViewController = mainViewController

        window!.makeKeyAndVisible()

        return true
    }

}
