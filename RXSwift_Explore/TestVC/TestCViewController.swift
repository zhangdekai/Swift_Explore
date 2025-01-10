//
//  TestCViewController.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2020/8/16.
//  Copyright © 2020 mr dk. All rights reserved.
//

import UIKit
import SwiftUI

class TestCViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSwiftUI();
    }
    
    /// add in viewDidLoad()
    func addSwiftUI(){
        
        let swiftUI = SwiftUIViewTest1()
        let hostingController = UIHostingController(rootView: swiftUI)
        // 添加到当前 ViewController
        addChild(hostingController)
        hostingController.view.frame = view.bounds
        view.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
    }
    
}
