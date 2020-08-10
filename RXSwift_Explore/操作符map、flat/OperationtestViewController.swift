//
//  OperationtestViewController.swift
//  RXSwift_Explore
//
//  Created by 0608 on 2020/7/25.
//  Copyright © 2020 mr dk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class OperationtestViewController: UIViewController {

    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testCombinationOperators()

    }
    func testCombinationOperators() {
        
        // *** startWith : 在开始从可观察源发出元素之前，发出指定的元素序列
        print("*****startWith*****")
        Observable.of("1", "2", "3", "4")
        .startWith("A")
        .startWith("B")
        .startWith("C","a","b")
        .subscribe(onNext: {print($0)})
        .disposed(by: bag)
        //效果: CabBA1234

         // **** merge : 将源可观察序列中的元素组合成一个新的可观察序列，并将像每个源可观察序列发出元素一样发出每个元素
        
        print("*****merge*****")

        let subject1 = PublishSubject<String>()
        let subject2 = PublishSubject<String>()

        Observable.of(subject1,subject2)
        .merge()
        .subscribe(onNext: {print($0)})
        .disposed(by: bag)
        
        subject1.onNext("C")
        subject1.onNext("o")
        subject2.onNext("o")
        subject2.onNext("o")
        subject1.onNext("c")
        subject2.onNext("i")
        // Cooci - 任何一个响应都会勾起新序列响应

        // : Coooci
         //  *** zip: 将多达8个源可观测序列组合成一个新的可观测序列，并将从组合的可观测序列中发射出对应索引处每个源可观测序列的元素
        
        print("*****zip*****")

        let arra = [1,2,34]
//        arra.compactMap(<#T##transform: (Int) throws -> ElementOfResult?##(Int) throws -> ElementOfResult?#>)
        
        
            
    }
}
