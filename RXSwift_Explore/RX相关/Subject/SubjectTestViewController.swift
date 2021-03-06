//
//  SubjectTestViewController.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2020/8/16.
//  Copyright © 2020 mr dk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SubjectTestViewController: UIViewController {
    
    let disposbag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testSubject()
    }
    
    
    func testSubject1() {
        // 在RxsWift中还有一种非常特殊的序列 Subject- 即公也为受
        // Subject是一个代理，它既是Observer，也是Observable
        // PublishSubject
        // 1:初始化序列
        let publishSub = PublishSubject<Int>() //初始化一个PublishSubject 装着Int类型的序列
        
        // 2:发送响应序列
        publishSub.onNext(1)
        // 3:订阅序列
        publishSub.subscribe { print("订阅到了:",$0)}
            .disposed(by: disposbag)
        // 再次发送响应
        publishSub.onNext(2)
        publishSub.onNext(3)
        
        print("**********BehaviorSubject**********")
        // BehaviorSubject
        // 1:创建序列
        let behaviorSub = BehaviorSubject.init(value: 100)
        // 2:发送信号
        behaviorSub.onNext(2)
        behaviorSub.onNext(3)
        // 3:订阅序列
        behaviorSub.subscribe{ print("订阅到了:",$0)}
            .disposed(by: disposbag)
        // 再次发送
        behaviorSub.onNext(4)
        behaviorSub.onNext(5)
        // 再次订阅
        behaviorSub.subscribe{ print("订阅到了:",$0)}
            .disposed(by: disposbag)
        
        print("**********ReplaySubject**********")
        // ReplaySubject
        // 1:创建序列
        let replaySub = ReplaySubject<Int>.create(bufferSize: 2)
        // let replaySub = ReplaySubject<Int>.createUnbounded()
        
        // 2:发送信号
        replaySub.onNext(1)
        replaySub.onNext(2)
        replaySub.onNext(3)
        replaySub.onNext(4)
        
        // 3:订阅序列
        replaySub.subscribe{ print("订阅到了:",$0)}
            .disposed(by: disposbag)
        // 再次发送
        replaySub.onNext(7)
        replaySub.onNext(8)
        replaySub.onNext(9)
        
        print("**********AsyncSubject**********")
        // AsyncSubject
        // 1:创建序列
        let asynSub = AsyncSubject<Int>.init()
        // 2:发送信号
        asynSub.onNext(1)
        asynSub.onNext(2)
        // 3:订阅序列
        asynSub.subscribe{ print("订阅到了:",$0)}
            .disposed(by: disposbag)
        // 再次发送
        asynSub.onNext(3)
        asynSub.onNext(4)
        asynSub.onError(NSError.init(domain: "lgcooci", code: 10086, userInfo: nil))
        asynSub.onCompleted()
        
        print("**********Variable**********")
        // Variable : 5.0已经废弃(BehaviorSubject 替换) - 这里板书 大家可以了解一下
        
        // 1:创建序列
        let variableSub = Variable.init(1)
        // 2:发送信号
        variableSub.value = 100
        variableSub.value = 10
        // 3:订阅信号
        variableSub.asObservable().subscribe{ print("订阅到了:",$0)}
            .disposed(by: disposbag)
        // 再次发送
        variableSub.value = 1000
        
    }
    
    
    func testSubject() {
        behaviorSubjectE.subscribe(onNext: { (num) in
            print("behaviorSubjectE num:\(num)")
        }).disposed(by: disposbag)
        
        behaviorRelay.subscribe(onNext: { (num) in
            print("behaviorRelay num:\(num)")
        }).disposed(by: disposbag)
        
        replaySubject.subscribe(onNext: { (num) in
            print("replaySubject num:\(num)")
        }).disposed(by: disposbag)
        
        publishSubject.subscribe(onNext: { (num) in
            print("publishSubject num:\(num)")
        }).disposed(by: disposbag)
        
        asyncSubject.subscribe(onNext: { (num) in
            
            print("asyncSubject num:\(num)")
            
        }).disposed(by: disposbag)
        
    }
    
    var behaviorSubjectE = BehaviorSubject.init(value: 112)
    var countNum = 1123
    @IBAction func BehaviorSubjectAction(_ sender: Any) {
        
        countNum += 1
        behaviorSubjectE.onNext(countNum)
    }
    
    var behaviorRelay = BehaviorRelay<Int>.init(value: 3000)
    
    @IBAction func BehaviorRelayAction(_ sender: Any) {
        
        countNum += 1
        
        behaviorRelay.accept(countNum)
    }
    
    var replaySubject = ReplaySubject<Int>.create(bufferSize: 2)
    
    @IBAction func ReplaySubjectAction(_ sender: Any) {
        
        replaySubject.onNext(countNum)
        
    }
    
    var publishSubject = PublishSubject<Int>()
    @IBAction func PublishSubjectAction(_ sender: Any) {
        
        publishSubject.onNext(countNum)
    }
    
    var asyncSubject = AsyncSubject<Int>()
    
    @IBAction func AsyncSubjectAction(_ sender: Any) {
        
        asyncSubject.onNext(countNum)
        
        // AsyncSubject 只有检测到 Complete 才会响应
        asyncSubject.onCompleted()
    }
    
    
    
}
