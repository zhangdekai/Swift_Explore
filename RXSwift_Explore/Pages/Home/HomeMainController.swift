//
//  HomeMainControoler.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2025/2/28.
//  Copyright © 2025 mr dk. All rights reserved.
//

import Foundation
import UIKit
/*
 
 https://chatgpt.com/canvas/shared/67c13c2f6fa88191b608341c3b5d0d96
 */

class HomeMainTabBarController: UITabBarController {
    
    let home = HomeViewController.instanceController(.main)
    let explore = HomeExploreController()
    let message = HomeMessageViewController()
    let profile = HomeProfieViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homeVC = UINavigationController(rootViewController: home)
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let exploreVC = UINavigationController(rootViewController: explore)
        exploreVC.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass"))
        
        let messageVC = UINavigationController(rootViewController: message)
        messageVC.tabBarItem = UITabBarItem(title: "Message", image: UIImage(systemName: "message"), selectedImage: UIImage(systemName: "message.fill"))
        
        let profileVC = UINavigationController(rootViewController: profile)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        viewControllers = [homeVC, exploreVC, messageVC, profileVC]
    }
}
