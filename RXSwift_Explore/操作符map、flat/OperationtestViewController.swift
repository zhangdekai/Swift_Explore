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
//        testCombinationOperators()
        
        testTransformingOperators()
        

    }
    
    func testTransformingOperators() {
        // ***** map: 转换闭包应用于可观察序列发出的元素，并返回转换后的元素的新可观察序列。
        print("*****map*****")
               let ob = Observable.of(1,2,3,4)
        
        ob.map{ (num) -> Int in
            return num + 2
        }.subscribe{ print($0) }
        .disposed(by: bag)
        
        // 将可观测序列发射的元素转换为可观测序列，并将两个可观测序列的发射合并为一个可观测序列。
        // 这也很有用，例如，当你有一个可观察的序列，它本身发出可观察的序列，你想能够对任何一个可观察序列的新发射做出反应(序列中序列:比如网络序列中还有模型序列)
        // flatMap和flatMapLatest的区别是，flatMapLatest只会从最近的内部可观测序列发射元素
        
        print("*****flatMap*****")
               let boy  = LGPlayer(score: 100)
               let girl = LGPlayer(score: 90)
               let player = BehaviorSubject(value: boy)
        
        player.asObservable()
            .flatMap{ $0.score.asObservable() }
        .subscribe(onNext: { print($0)})
        .disposed(by: bag)
        
        
        
        
        
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
        
        print("*****zip*****")
        let stringSubject = PublishSubject<String>()
        let intSubject = PublishSubject<Int>()
        
        Observable.zip(stringSubject, intSubject){ strE, intE in "\(strE),\(intE)"}
        .subscribe(onNext: { print($0)})
        .disposed(by: bag)
        
//        stringSubject.onNext(<#T##element: String##String#>)
    
    }
}
