//
//  TestBViewController.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2020/8/16.
//  Copyright © 2020 mr dk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TestBViewController: UIViewController {
    
    let bag = DisposeBag()
    
    private lazy var rejectButton: UIButton = {
        let button = UIButton()
        button.setTitle("返回", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        return button
    }()
    fileprivate var publishSubject = PublishSubject<String>()
    
    // 序列传值  订阅使用
    var toDoOb: Observable<String> {
        return publishSubject.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(rejectButton)
        rejectButton.snp.makeConstraints { (make) in
            make.top.left.equalTo(100)
            make.width.equalTo(100)
            make.height.equalTo(30)
        }
        
        rejectButton.rx.tap.subscribe(onNext: {[weak self] () in

            self?.publishSubject.onNext("我来自TestB")
            self?.navigationController?.popViewController(animated: true)
        }).disposed(by: bag)
        
        
    }
}
