//
//  AppDelegate.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2020/7/14.
//  Copyright © 2020 mr dk. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = ViewController.instanceController(.main)

        let nav = UINavigationController(rootViewController: vc)
        
        window?.rootViewController = nav
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

