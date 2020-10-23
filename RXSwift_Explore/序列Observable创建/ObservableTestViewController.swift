//
//  ObservableTestViewController.swift
//  RXSwift_Explore
//
//  Created by 0608 on 2020/7/22.
//  Copyright © 2020 mr dk. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class ObservableTestViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MARK: observable创建
        // 首先来一个空的序列 - 本来序列事件是Int类型的,这里调用emty函数 没有序列,只能complete
        print("********emty********")
        let emtyOb = Observable<Int>.empty()
        let _ = emtyOb.subscribe(onNext: { (number) in
            print("订阅:",number)
        }, onError: { (error) in
            print("error:",error)
        }, onCompleted: {
            print("完成回调")
        }) {
            print("释放回调")
        }
        
        print("********just********")
        
       //MARK:  just
       // 单个信号序列创建
       let array = ["LG_Cooci","LG_Kody"]
       Observable<[String]>.just(array)
           .subscribe { (event) in
               print(event)
           }.disposed(by: disposeBag)
       
       let _ = Observable<[String]>.just(array).subscribe(onNext: { (number) in
           print("订阅:",number)
       }, onError: { (error) in
           print("error:",error)
       }, onCompleted: {
           print("完成回调")
       }) {
           print("释放回调")
       }
       
       print("********of********")
        
       //MARK:  of
       // 多个元素 - 针对序列处理
       Observable<String>.of("LG_Cooci","LG_Kody")
           .subscribe { (event) in
               print(event)
           }.disposed(by: disposeBag)
        
        Observable<String>.of("说你错了呢")
            .subscribe { (event) in
                print(event)
        }.disposed(by: disposeBag)
       
       // 字典
       Observable<[String: Any]>.of(["name":"LG_Cooci","age":18])
           .subscribe { (event) in
               print(event)
           }.disposed(by: disposeBag)
        
        Observable<[String:Any]>.of(["name":"男士内裤","age":20])
            .subscribe { (event) in
                print(event)
        }.disposed(by: disposeBag)
       
       // 数组
       Observable<[String]>.of(["LG_Cooci","LG_Kody"])
           .subscribe { (event) in
               print(event)
           }.disposed(by: disposeBag)
       
       print("********from********")

        //MARK:  from
        // 从集合中获取序列:数组,集合,set 获取序列 - 有可选项处理 - 更安全
        Observable<[String]>.from(optional: ["LG_Cooci","LG_Kody"])
            .subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
        
        
        print("********defer********")
        //MARK:  defer
        // 这里有一个需求:动态序列 - 根据外界的标识 - 动态输出
        // 使用deferred()方法延迟Observable序列的初始化，通过传入的block来实现Observable序列的初始化并且返回。
        var isOdd = true
        let _ = Observable<Int>.deferred { () -> Observable<Int> in
            // 这里设计我们的序列
            isOdd = !isOdd
            if isOdd {
                return Observable.of(1,3,5,7,9)
            }
            return Observable.of(0,2,4,6,8)
            }
            .subscribe { (event) in
                print(event)
        }
        
        print("********rang********")
        //MARK:  rang
        // 生成指定范围内的可观察整数序列。
        Observable.range(start: 2, count: 5)
            .subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
        
        print("********generate********")
        
        //MARK:  generate
        // 该方法创建一个只有当提供的所有的判断条件都为 true 的时候，才会给出动作的 Observable 序列。
        // 初始值给定 然后判断条件1 再判断条件2 会一直递归下去,直到条件1或者条件2不满足
        // 类似 数组遍历循环
        
        Observable.generate(initialState: 1, condition: {$0 < 10}, iterate: {$0 + 2}).subscribe { (event) in
            print(event)
        }.disposed(by: disposeBag)
        
        // 数组遍历
        let arr = ["LG_Cooci_1","LG_Cooci_2","LG_Cooci_3","LG_Cooci_4","LG_Cooci_5","LG_Cooci_6","LG_Cooci_7","LG_Cooci_8","LG_Cooci_9","LG_Cooci_10"]
        
        Observable.generate(initialState: 0, condition: {$0 < arr.count}, iterate: {$0 + 1})
            .subscribe(onNext: { (ele) in
                               
                print("遍历arr:",ele)

            }).disposed(by: disposeBag)
        
        
        print("********timer********")
               //MARK:  timer
               // 第一次参数:第一次响应距离现在的时间
               // 第二个参数:时间间隔
               // 第三个参数:线程
        
        Observable<Int>.timer(DispatchTimeInterval.seconds(1), period: DispatchTimeInterval.seconds(2), scheduler: MainScheduler.instance)
            .subscribe { (event) in
                print(event)
        }.disposed(by: disposeBag)
        
        Observable<Int>.timer(DispatchTimeInterval.seconds(3), scheduler: MainScheduler.instance).skip(1)
            .subscribe { (event) in
                print("s不是薄纱似的 ")
        }.disposed(by: disposeBag)
        
        
        print("********interval********")
               //MARK:  interval
               // 定时器
        Observable<Int>.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
            .subscribe { (event) in
                print(event)
        }.disposed(by: disposeBag)
        
        
        print("********repeatElement********")
        //MARK:  repeatElement
        // 该方法创建一个可以无限发出给定元素的 Event的 Observable 序列（永不终止）
//        Observable<Int>.repeatElement(5)
//            .subscribe { (event) in
//                print("repeatElement  :\(event)")
//        }.disposed(by: disposeBag)
        
        print("********error********")
               //MARK:  error
               // 对消费者发出一个错误信号
        
        Observable<String>.error(NSError.init(domain: "lgerror", code: 10086, userInfo: ["reason":"unkonw"]))
            .subscribe { (event) in
                print("订阅:\(event)")
        }.disposed(by: disposeBag)
        
        
        
        print("********never********")
               //MARK:  never
               // 该方法创建一个永远不会发出 Event（也不会终止）的 Observable 序列。
               // 这种类型的响应源 在测试或者在组合操作符中禁用确切的源非常有用
        Observable<String>.never()
            .subscribe { (event) in
                print("揍你")
        }.disposed(by: disposeBag)
        print("********never********")


    }
    


}
