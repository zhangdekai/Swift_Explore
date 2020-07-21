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

class ATestViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //MARK: observable创建
        // 首先来一个空的序列 - 本来序列事件是Int类型的,这里调用emty函数 没有序列,只能complete
        print("********emty********")
        
        print("********just********")
        //MARK:  just
        // 单个信号序列创建
        
        print("********of********")
        //MARK:  of
       
        print("********from********")
        //MARK:  from
        // 从集合中获取序列:数组,集合,set 获取序列 - 有可选项处理 - 更安全
      
        print("********defer********")
        //MARK:  defer
        // 这里有一个需求:动态序列 - 根据外界的标识 - 动态输出
        // 使用deferred()方法延迟Observable序列的初始化，
        // 通过传入的block来实现Observable序列的初始化并且返回。
        
        
        print("********rang********")
        //MARK:  rang
        // 生成指定范围内的可观察整数序列。
       
        
        print("********generate********")
        //MARK:  generate
        // 该方法创建一个只有当提供的所有的判断条件都为 true 的时候，
        // 才会给出动作的 Observable 序列。
        // 初始值给定 然后判断条件1 再判断条件2 会一直递归下去,直到条件1或者条件2不满足
        // 类似 数组遍历循环
     
        
        print("********timer********")
        //MARK:  timer
        // 第一次参数:第一次响应距离现在的时间
        // 第二个参数:时间间隔
        // 第三个参数:线程
    
        
        print("********interval********")
        //MARK:  interval
        // 定时器

        print("********repeatElement********")
        //MARK:  repeatElement
        // 该方法创建一个可以无限发出给定元素的 Event的 Observable 序列（永不终止）
       
        
        print("********error********")
        //MARK:  error
        // 对消费者发出一个错误信号
        
        print("********never********")
        //MARK:  never
        // 该方法创建一个永远不会发出 Event（也不会终止）的 Observable 序列。
        
        
        print("********never********")
        
    }
    
    func observeableCreatMethod(){
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
        
        // 字典
        Observable<[String: Any]>.of(["name":"LG_Cooci","age":18])
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
        Observable.generate(initialState: 0,// 初始值
            condition: { $0 < 10}, // 条件1
            iterate: { $0 + 2 })  // 条件2 +2
            .subscribe { (event) in
                print(event)
            }.disposed(by: disposeBag)
        
        // 数组遍历
        let arr = ["LG_Cooci_1","LG_Cooci_2","LG_Cooci_3","LG_Cooci_4","LG_Cooci_5","LG_Cooci_6","LG_Cooci_7","LG_Cooci_8","LG_Cooci_9","LG_Cooci_10"]
        Observable.generate(initialState: 0,// 初始值
            condition: { $0 < arr.count}, // 条件1
            iterate: { $0 + 1 })  // 条件2 +2
            .subscribe(onNext: {
                print("遍历arr:",arr[$0])
            })
            .disposed(by: disposeBag)
        
        
        print("********timer********")
        //MARK:  timer
        // 第一次参数:第一次响应距离现在的时间
        // 第二个参数:时间间隔
        // 第三个参数:线程
        Observable<Int>.timer(5, period: 2, scheduler: MainScheduler.instance)
            .subscribe { (event) in
                // print(event)
            }
            .disposed(by: disposeBag)
        
        // 因为没有指定期限period,故认定为一次性
        Observable<Int>.timer(1, scheduler: MainScheduler.instance)
            .subscribe { (event) in
                // print("111111111")
            }
            .disposed(by: disposeBag)
        
        
        print("********interval********")
        //MARK:  interval
        // 定时器
        Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .subscribe { (event) in
                // print(event)
            }
            .disposed(by: disposeBag)
        
        print("********repeatElement********")
        //MARK:  repeatElement
        // 该方法创建一个可以无限发出给定元素的 Event的 Observable 序列（永不终止）
        Observable<Int>.repeatElement(5)
            .subscribe { (event) in
                // print("订阅:",event)
            }
            .disposed(by: disposeBag)
        
        print("********error********")
        //MARK:  error
        // 对消费者发出一个错误信号
        Observable<String>.error(NSError.init(domain: "lgerror", code: 10086, userInfo: ["reason":"unknow"]))
            .subscribe { (event) in
                print("订阅:",event)
            }
            .disposed(by: disposeBag)
        
        print("********never********")
        //MARK:  never
        // 该方法创建一个永远不会发出 Event（也不会终止）的 Observable 序列。
        // 这种类型的响应源 在测试或者在组合操作符中禁用确切的源非常有用
        Observable<String>.never()
            .subscribe { (event) in
                print("走你",event)
            }
            .disposed(by: disposeBag)
        print("********never********")
    }
    
}
