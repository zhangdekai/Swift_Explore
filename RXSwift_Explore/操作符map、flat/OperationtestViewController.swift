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

/// 延迟几秒执行
func delay(_ delay: Double, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}

class OperationtestViewController: UIViewController {
    
    var bag = DisposeBag()
    let lgError = NSError.init(domain: "com.lgerror.cn", code: 10090, userInfo: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        testCombinationOperators()
        
        //        testTransformingOperators()
        //        testFilteringConditionalOperators()
        //        testMathematicalAggregateOperators()
        //        testErrorHandlingOperators()
        //        testDebug()
        //        testMulticastConnectOperators()
        
        //        testReplayConnectOperators()
        
        //        testPushConnectOperators()
        
        testWithoutConnect()
        
    }
    
    /// 没有共享序列
    func testWithoutConnect() {
        
        print("*****testWithoutConnect*****")
        
        let interval = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        interval.subscribe(onNext: { (num) in
            print("订阅1：\(num)")
        }).disposed(by: bag)
        
        delay(3) {
            // 该订阅计数又从 0 开始计数的， 与 订阅1 没有共享
            interval.subscribe(onNext: { print("订阅: 2, 事件: \($0)") })
                .disposed(by: self.bag)
        }
        delay(10, closure: {
            self.bag = DisposeBag()
        })
        
        //        _ = interval.connect()
        
    }
    
    /// publish - connect 将源可观察序列转换为可连接序列
    func testPushConnectOperators(){
        
        // **** push:将源可观察序列转换为可连接序列
        // 共享一个Observable的事件序列，避免创建多个Observable sequence。
        // 注意:需要调用connect之后才会开始发送事件
        print("*****testPushConnect*****")
        
        let interval = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).publish()
        
        delay(2) {
            _ = interval.connect()
        }
        delay(4) {
            interval.subscribe(onNext: { print("订阅: 2, 事件: \($0)") })
                .disposed(by: self.bag)
        }
        delay(6) {
            interval.subscribe(onNext: { print("订阅: 3, 事件: \($0)") })
                .disposed(by: self.bag)
        }
        delay(10, closure: {
            self.bag = DisposeBag()
        })
    }
    
    /// replay
    func testReplayConnectOperators() {
        // **** replay: 将源可观察序列转换为可连接的序列，并将向每个新订阅服务器重放以前排放的缓冲大小
        // 首先拥有和publish一样的能力，共享 Observable sequence， 其次使用replay还需要我们传入一个参数（buffer size）来缓存已发送的事件，当有新的订阅者订阅了，会把缓存的事件发送给新的订阅者
        print("*****replay*****")
        
        let interval = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).replay(5)
        interval.subscribe({ print($0)})
            .disposed(by: bag)
        
        delay(2) {
            _ = interval.connect()
        }
        
        delay(4) {
            interval.subscribe(onNext: { print(Date.time,"订阅: 2, 事件: \($0)") })
                .disposed(by: self.bag)
        }
        
        delay(8) {
            interval.subscribe(onNext: { print(Date.time,"订阅: 3, 事件: \($0)") })
                .disposed(by: self.bag)
        }
        delay(20, closure: {
            self.bag = DisposeBag()
        })
        
        
    }
    
    /// 链接操作符
    /// multicast
    func testMulticastConnectOperators(){
        // *** multicast : 将源可观察序列转换为可连接序列，并通过指定的主题广播其发射。
        print("*****multicast*****")
        let subject = PublishSubject<Any>()
        subject.subscribe({ print("00: \($0)")})
            .disposed(by: bag)
        
        let netOb = Observable<Any>.create { (observer) -> Disposable in
            
            sleep(2)
            print("我开始请求网络了")
            observer.onNext("请求到的网络数据")
            observer.onNext("请求到的本地")
            observer.onCompleted()
            
            return Disposables.create {
                print("销毁回调了")
            }
        }.publish()
        
        
        netOb.subscribe(onNext: { (any) in
            print("订阅1:",any)
        })
            .disposed(by: bag)
        
        netOb.subscribe(onNext: { (any) in
            print("订阅2:",any)
        })
            .disposed(by: bag)
        
        _ = netOb.connect()//写在此位置，才能两个订阅一块响应
    }
    
    func testDebug() {
        // **** debug
        // 打印所有订阅、事件和处理。
        print("*****debug*****")
        var count = 1
        
        let sequenceThatErrors = Observable<String>.create { (observer) -> Disposable in
            
            observer.onNext("DK")
            observer.onNext("DK1")
            observer.onNext("DK2")
            
            if count < 5 {
                observer.onError(self.lgError)
                print("错误序列来了")
                count += 1
            }
            
            observer.onNext("Lina")
            observer.onNext("小雁子")
            observer.onNext("可心")
            observer.onCompleted()
            
            return Disposables.create()
        }
        
        sequenceThatErrors.retry(3)
            .debug()
            .subscribe(onNext: { (str) in
                print(str)
            })
            .disposed(by: bag)
    }
    
    /// 从可观察对象的错误通知中恢复的操作符。
    func testErrorHandlingOperators() {
        // **** catchErrorJustReturn
        // 从错误事件中恢复，方法是返回一个可观察到的序列，该序列发出单个元素，然后终止
        print("*****catchErrorJustReturn*****")
        
        let sub = PublishSubject<String>()
        
        sub.catchErrorJustReturn("DK——Error")
            .subscribe { print($0)}
            .disposed(by: bag)
        
        sub.onNext("Dk1")
        sub.onNext("DK2")
        sub.onError(lgError)
        
        // **** catchError
        // 通过切换到提供的恢复可观察序列，从错误事件中恢复
        print("*****catchError*****")
        
        let sub1 = PublishSubject<String>()
        sub1.catchError {
            print("error:\($0)")
            return sub1
        }
        .subscribe{ print($0)}
        .disposed(by: bag)
        
        sub1.onNext("DD1")
        sub1.onNext("DD2")
        
        sub1.onError(lgError)
        
        sub1.onNext("DD3")
        
        
        // *** retry: 通过无限地重新订阅可观察序列来恢复重复的错误事件
        print("*****retry*****")
        var count = 1 // 外界变量控制流程
        let sub2 = Observable<String>.create { (observer) -> Disposable in
            observer.onNext("KK1")
            observer.onNext("KK2")
            observer.onNext("KK3")
            
            if count == 1 {
                //流程进来之后就会过度-这里的条件可以作为出口,失败的次数
                observer.onError(self.lgError)  // 接收到了错误序列,重试序列发生
                print("错误序列来了")
                count += 1
            }
            observer.onNext("KK4")
            observer.onNext("KK5")
            observer.onNext("KK6")
            observer.onCompleted()
            
            return Disposables.create()
        }
        sub2.retry()
            .subscribe { print($0)}
            .disposed(by: bag)
        
        // **** retry(_:): 通过重新订阅可观察到的序列，重复地从错误事件中恢复，直到重试次数达到max未遂计数
        print("*****retry(_:)*****")
        
        let sub3 = Observable<String>.create { (observer) -> Disposable in
            
            observer.onNext("KK1")
            observer.onNext("KK2")
            observer.onNext("KK30000")
            
            if count < 5 {
                //流程进来之后就会过度-这里的条件可以作为出口,失败的次数
                observer.onError(self.lgError)  // 接收到了错误序列,重试序列发生
                print("错误序列来了")
                count += 1
            }
            observer.onNext("KK4")
            observer.onNext("KK5")
            observer.onNext("KK10000")
            observer.onCompleted()
            
            return Disposables.create()
        }
        
        sub3.retry(3)
            .subscribe { print($0)}
            .disposed(by: bag)
        
    }
    
    /// 集合控制操作符
    func testMathematicalAggregateOperators() {
        
        // *** toArray: 将一个可观察序列转换为一个数组，将该数组作为一个新的单元素可观察序列发出，然后终止
        print("*****toArray*****")
        Observable.range(start: 1, count: 10)
            .toArray()
            .subscribe { print($0)}
            .disposed(by: bag)
        
        // *** reduce: 从一个设置的初始化值开始，然后对一个可观察序列发出的所有元素应用累加器闭包，并以单个元素可观察序列的形式返回聚合结果 - 类似scan
        print("*****reduce*****")
        Observable.of(2, 3, 4)
            .reduce(1, accumulator: *)// 0 + 10 + 100 + 1000 = 1111
            .subscribe(onNext: { print($0)})
            .disposed(by: bag)
        
        // *** concat: 以顺序方式连接来自一个可观察序列的内部可观察序列的元素，在从下一个序列发出元素之前，等待每个序列成功终止
        // 用来控制顺序
        print("*****concat*****")
        
        let sub1 = BehaviorSubject(value: "DK")
        let sub2 = BehaviorSubject(value: "1")
        
        let sub = BehaviorSubject(value: sub1)
        
        sub.asObservable()
            .concat()
            .subscribe { print($0) }
            .disposed(by: bag)
        
        sub1.onNext("DK1")
        sub1.onNext("DK2")
        
        sub.onNext(sub2)
        
        sub2.onNext("DK3")
        sub2.onNext("DK4")
        
        sub1.onCompleted()// 必须要等subject1 完成了才能订阅到! 用来控制顺序 网络数据的异步
        
        sub2.onNext("DK5")// D4 D5 会打印之前一个的
    }
    
    /// 过滤条件操作符
    func testFilteringConditionalOperators() {
        // **** filter : 仅从满足指定条件的可观察序列中发出那些元素
        
        print("*****filter*****")
        
        Observable.of(1,2,3,4,5,6,7,8,9,0)
            .filter{ $0 % 2 == 0 }//偶数
            .subscribe(onNext: { print($0)})
            .disposed(by: bag)
        
        // ***** 去重 distinctUntilChanged: 抑制可观察序列发出的顺序重复元素
        print("*****distinctUntilChanged*****")
        
        Observable.of("1", "2", "2", "2", "3", "3", "4")
            .distinctUntilChanged()
            .subscribe(onNext: { print($0)})
            .disposed(by: bag)
        
        // **** elementAt: 仅在可观察序列发出的所有元素的指定索引处发出元素
        print("*****elementAt*****")
        Observable.of("C", "o", "K", "c", "i")
            .elementAt(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: bag)
        
        // *** single: 只发出可观察序列发出的第一个元素(或满足条件的第一个元素)。如果可观察序列发出多个元素，将抛出一个错误。
        
        print("*****single*****")
        Observable.of("Cooci", "Kody")
            .single()
            .subscribe(onNext: { print($0) })
            .disposed(by: bag)
        
        Observable.of("Cocoi","DK")
            .single{ $0 == "DK"}//筛选
            .subscribe(onNext: { print($0)})
            .disposed(by: bag)
        
        // **** take: 只从一个可观察序列的开始发出指定数量的元素。 上面signal只有一个序列 在实际开发会受到局限 这里引出 take 想几个就几个
        print("*****take*****")
        Observable.of("Hank", "Kody","Cooci", "CC")
            .take(3)
            .subscribe(onNext: { print($0)})
            .disposed(by: bag)
        
        // **** takeWhile: 只要指定条件的值为true，就从可观察序列的开始发出元素
        print("*****takeWhile*****")
        Observable.of(1, 2, 3, 4, 5, 6)
            .takeWhile { $0 < 4 }
            .subscribe(onNext: { print($0)})
            .disposed(by: bag)
        
        // ***** takeUntil: 从源可观察序列发出元素，直到参考可观察序列发出元素
        // 这个要重点,应用非常频繁 比如我页面销毁了,就不能获取值了(cell重用运用)
        print("*****takeUntil*****")
        let sourceSequence = PublishSubject<String>()
        let referenceSequence = PublishSubject<String>()
        
        sourceSequence
            .takeUntil(referenceSequence)
            .subscribe(onNext: { print($0)})
            .disposed(by: bag)
        
        sourceSequence.onNext("Cooci")
        sourceSequence.onNext("Kody")
        sourceSequence.onNext("CC")
        
        referenceSequence.onNext("Hank")// 条件一出来,下面就走不了
        
        sourceSequence.onNext("Lina")
        sourceSequence.onNext("小雁子")
        sourceSequence.onNext("婷婷")
        
        // ***** skip: 从源可观察序列发出元素，直到参考可观察序列发出元素
        // 这个要重点,应用非常频繁 不用解释 textfiled 都会有默认序列产生
        print("*****skip*****")
        Observable.of(1, 2, 3, 4, 5, 6)
            .skip(2)
            .subscribe(onNext: { print($0)})
            .disposed(by: bag)
        
        
        print("*****skipWhile*****")
        Observable.of(1, 2, 3, 4, 5, 6)
            .skipWhile { $0 < 4}
            .subscribe(onNext: { print($0)})
            .disposed(by: bag)
        
        
        // *** skipUntil: 抑制从源可观察序列发出元素，直到参考可观察序列发出元素
        print("*****skipUntil*****")
        let sourceSeq = PublishSubject<String>()
        let referenceSeq = PublishSubject<String>()
        
        sourceSeq
            .skipUntil(referenceSeq)
            .subscribe(onNext: { print($0) })
            .disposed(by: bag)
        
        // 没有条件命令 下面走不了
        sourceSeq.onNext("Cooci")
        sourceSeq.onNext("Kody")
        sourceSeq.onNext("CC")
        
        referenceSeq.onNext("Hank") // 条件一出来,下面就可以走了
        
        sourceSeq.onNext("Lina")
        sourceSeq.onNext("小雁子")
        sourceSeq.onNext("婷婷")
    }
    
    /// 映射操作符
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
        
        boy.score.onNext(60)
        player.onNext(girl)
        
        boy.score.onNext(50)
        boy.score.onNext(40)
        
        girl.score.onNext(10)
        girl.score.onNext(0)
        
        // flatMapLatest实际上是map和switchLatest操作符的组合。
        
        // ** scan: 从初始就带有一个默认值开始，然后对可观察序列发出的每个元素应用累加器闭包，并以单个元素可观察序列的形式返回每个中间结果
        print("*****scan*****")
        
        
        
        
    }
    
    /// 组合操作符
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

struct LGPlayer {
    init(score: Int) {
        self.score = BehaviorSubject(value: score)
    }
    let score: BehaviorSubject<Int>
}

extension Date {
    static var time: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH-mm-ss"
        return formatter.string(from: Date())
    }
}
