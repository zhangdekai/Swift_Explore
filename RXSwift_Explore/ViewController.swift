//
//  ViewController.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2020/7/14.
//  Copyright © 2020 mr dk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Observable.create(<#T##subscribe: (AnyObserver<_>) -> Disposable##(AnyObserver<_>) -> Disposable#>)

    }

    @IBAction func jumpToFRP(_ sender: Any) {
        let vc =  FRPTestViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func jumpToShiLi(_ sender: Any) {
        
        
        //ps: storyboard 创建的VC 都需要使用下面来alloc vc
        let vc = RXSwiftRestViewController.instanceController(.main)

        
        self.present(vc, animated: true, completion: nil)
        
        
        
    }
    
    @IBAction func jumpLoginVC(_ sender: Any) {
        
        let vc = LoginViewController.instanceController(.main)
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
}

extension UIViewController:LoadStoryBoard {
    
}

