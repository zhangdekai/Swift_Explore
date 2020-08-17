//
//  TestAViewController.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2020/8/16.
//  Copyright © 2020 mr dk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TestAViewController: UIViewController {
    
    let bag = DisposeBag()
    
    lazy var rejectButton: UIButton = {
        let button = UIButton()
        button.setTitle("push", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        
        view.addSubview(rejectButton)
        rejectButton.snp.makeConstraints { (make) in
            make.top.left.equalTo(100)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        rejectButton.rx.tap.subscribe(onNext: {[weak self] () in
            let vc = TestBViewController()
            vc.toDoOb.subscribe(onNext: { (str) in
                self?.rejectButton.setTitle(str, for: .normal)
            }).disposed(by: vc.bag )
            
            self?.navigationController?.pushViewController(vc, animated: true)
        }).disposed(by: bag)
        
    }
    
}
