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


class ViewController: UIViewController {
    
    let lgError = NSError.init(domain: "com.lgerror.cn", code: 10090, userInfo: nil)
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print("*****combinationOperators*****")
        testCombinationOperators()
//
//        print("*****testTransformingOperators*****")
//        testTransformingOperators()
//
//        print("*****testFilteringConditionalOperators*****")
//        testFilteringConditionalOperators()
//
//        print("*****testMathematicalAggregateOperators*****")
//        testMathematicalAggregateOperators()
        
//        print("*****ConnectableOperators*****")
//        testConnectableOperators()
        
//        print("*****ErrorHandlingOperators*****")
//        testErrorHandlingOperators()
//
//        print("*****DebuggingOperators*****")
//        testDebuggingOperators()
    }
    
    /// 组合操作符
    func testCombinationOperators(){
        // *** startWith : 在开始从可观察源发出元素之前，发出指定的元素序列
        print("*****startWith*****")
        Observable.of("1", "2", "3", "4")
            .startWith("A")
            .startWith("B")
            .startWith("C", "a", "b")
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        //效果: CabBA1234
        
        // **** merge : 将源可观察序列中的元素组合成一个新的可观察序列，并将像每个源可观察序列发出元素一样发出每个元素
        print("*****merge*****")
        let subject1 = PublishSubject<String>()
        let subject2 = PublishSubject<String>()
        // merge subject1和subject2
        Observable.of(subject1, subject2)
            .merge()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        subject1.onNext("C")
        subject1.onNext("o")
        subject2.onNext("o")
        subject2.onNext("o")
        subject1.onNext("c")
        subject2.onNext("i")
        // Cooci - 任何一个响应都会勾起新序列响应
        
        //  *** zip: 将多达8个源可观测序列组合成一个新的可观测序列，并将从组合的可观测序列中发射出对应索引处每个源可观测序列的元素
        print("*****zip*****")
        let stringSubject = PublishSubject<String>()
        let intSubject = PublishSubject<Int>()

        Observable.zip(stringSubject, intSubject) { stringElement, intElement in
                "\(stringElement) \(intElement)"
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        stringSubject.onNext("C")
        stringSubject.onNext("o") // 到这里存储了 C o 但是不会响应除非;另一个响应

        intSubject.onNext(1) // 勾出一个
        intSubject.onNext(2) // 勾出另一个
        stringSubject.onNext("i") // 存一个
        intSubject.onNext(3) // 勾出一个
        // 说白了: 只有两个序列同时有值的时候才会响应,否则存值
        
        
        //  *****  combineLatest:将8源可观测序列组合成一个新的观测序列,并将开始发出联合观测序列的每个源的最新元素可观测序列一旦所有排放源序列至少有一个元素,并且当源可观测序列发出的任何一个新元素
        print("*****combineLatest*****")
        let stringSub = PublishSubject<String>()
        let intSub = PublishSubject<Int>()
        Observable.combineLatest(stringSub, intSub) { strElement, intElement in
                "\(strElement) \(intElement)"
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        stringSub.onNext("L") // 存一个 L
        stringSub.onNext("G") // 存了一个覆盖 - 和zip不一样
        intSub.onNext(1)      // 发现strOB也有G 响应 G 1
        intSub.onNext(2)      // 覆盖1 -> 2 发现strOB 有值G 响应 G 2
        stringSub.onNext("Cooci") // 覆盖G -> Cooci 发现intOB 有值2 响应 Cooci 2
        // combineLatest 比较zip 会覆盖
        // 应用非常频繁: 比如账户和密码同时满足->才能登陆. 不关系账户密码怎么变化的只要查看最后有值就可以 loginEnable
        
        // switchLatest : 将可观察序列发出的元素转换为可观察序列，并从最近的内部可观察序列发出元素
        print("*****switchLatest*****")
        let switchLatestSub1 = BehaviorSubject(value: "L")
        let switchLatestSub2 = BehaviorSubject(value: "1")
        let switchLatestSub  = BehaviorSubject(value: switchLatestSub1)// 选择了 switchLatestSub1 就不会监听 switchLatestSub2
        
        switchLatestSub.asObservable()
            .switchLatest()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        switchLatestSub1.onNext("G")
        switchLatestSub1.onNext("_")
        switchLatestSub2.onNext("2")
        switchLatestSub2.onNext("3") // 2-3都会不会监听,但是默认保存由 2覆盖1 3覆盖2
        switchLatestSub.onNext(switchLatestSub2) // 切换到 switchLatestSub2
        switchLatestSub1.onNext("*")
        switchLatestSub1.onNext("Cooci") // 原理同上面 下面如果再次切换到 switchLatestSub1会打印出 Cooci
        switchLatestSub2.onNext("4")
    }
    
    /// 映射操作符
    func testTransformingOperators(){
        
        // ***** map: 转换闭包应用于可观察序列发出的元素，并返回转换后的元素的新可观察序列。
        print("*****map*****")
        let ob = Observable.of(1,2,3,4)
        ob.map { (number) -> Int in
            return number+2
            }
            .subscribe{
                print("\($0)")
            }
            .disposed(by: disposeBag)
        // *** flatMap and flatMapLatest
        // 将可观测序列发射的元素转换为可观测序列，并将两个可观测序列的发射合并为一个可观测序列。
        // 这也很有用，例如，当你有一个可观察的序列，它本身发出可观察的序列，你想能够对任何一个可观察序列的新发射做出反应(序列中序列:比如网络序列中还有模型序列)
        // flatMap和flatMapLatest的区别是，flatMapLatest只会从最近的内部可观测序列发射元素
        print("*****flatMap*****")
        let boy  = LGPlayer(score: 100)
        let girl = LGPlayer(score: 90)
        let player = BehaviorSubject(value: boy)
        
        player.asObservable()
            .flatMap { $0.score.asObservable() } // 本身score就是序列 模型就是序列中的序列
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        boy.score.onNext(60)
        player.onNext(girl)
        boy.score.onNext(50)
        boy.score.onNext(40)//  如果切换到 flatMapLatest 就不会打印
        girl.score.onNext(10)
        girl.score.onNext(0)
        // flatMapLatest实际上是map和switchLatest操作符的组合。
        
        // ** scan: 从初始就带有一个默认值开始，然后对可观察序列发出的每个元素应用累加器闭包，并以单个元素可观察序列的形式返回每个中间结果
        print("*****scan*****")
        Observable.of(10, 100, 1000)
            .scan(2) { aggregateValue, newValue in
                aggregateValue + newValue // 10 + 2 , 100 + 10 + 2 , 1000 + 100 + 2
            }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        // 这里主要强调序列值之间的关系
    }
  
    /// 过滤条件操作符
    func testFilteringConditionalOperators(){
        
        // **** filter : 仅从满足指定条件的可观察序列中发出那些元素
        print("*****filter*****")
        Observable.of(1,2,3,4,5,6,7,8,9,0)
            .filter { $0 % 2 == 0 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        // ***** distinctUntilChanged: 抑制可观察序列发出的顺序重复元素
        print("*****distinctUntilChanged*****")
        Observable.of("1", "2", "2", "2", "3", "3", "4")
            .distinctUntilChanged()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        // **** elementAt: 仅在可观察序列发出的所有元素的指定索引处发出元素
        print("*****elementAt*****")
        Observable.of("C", "o", "o", "c", "i")
            .elementAt(3)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        // *** single: 只发出可观察序列发出的第一个元素(或满足条件的第一个元素)。如果可观察序列发出多个元素，将抛出一个错误。
        print("*****single*****")
        Observable.of("Cooci", "Kody")
            .single()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        Observable.of("Cooci", "Kody")
            .single { $0 == "Kody" }
            .subscribe { print($0) }
            .disposed(by: disposeBag)
   
        
        // **** take: 只从一个可观察序列的开始发出指定数量的元素。 上面signal只有一个序列 在实际开发会受到局限 这里引出 take 想几个就几个
        print("*****take*****")
        Observable.of("Hank", "Kody","Cooci", "CC")
            .take(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        // *** takeLast: 仅从可观察序列的末尾发出指定数量的元素
        print("*****takeLast*****")
        Observable.of("Hank", "Kody","Cooci", "CC")
            .takeLast(3)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        // **** takeWhile: 只要指定条件的值为true，就从可观察序列的开始发出元素
        print("*****takeWhile*****")
        Observable.of(1, 2, 3, 4, 5, 6)
            .takeWhile { $0 < 3 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        // ***** takeUntil: 从源可观察序列发出元素，直到参考可观察序列发出元素
        // 这个要重点,应用非常频繁 比如我页面销毁了,就不能获取值了(cell重用运用)
        print("*****takeUntil*****")
        let sourceSequence = PublishSubject<String>()
        let referenceSequence = PublishSubject<String>()
        
        sourceSequence
            .takeUntil(referenceSequence)
            .subscribe { print($0) }
            .disposed(by: disposeBag)
        
        sourceSequence.onNext("Cooci")
        sourceSequence.onNext("Kody")
        sourceSequence.onNext("CC")

        referenceSequence.onNext("Hank") // 条件一出来,下面就走不了
        
        sourceSequence.onNext("Lina")
        sourceSequence.onNext("小雁子")
        sourceSequence.onNext("婷婷")
        
        // ***** skip: 从源可观察序列发出元素，直到参考可观察序列发出元素
        // 这个要重点,应用非常频繁 不用解释 textfiled 都会有默认序列产生
        print("*****skip*****")
        Observable.of(1, 2, 3, 4, 5, 6)
            .skip(2)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        print("*****skipWhile*****")
        Observable.of(1, 2, 3, 4, 5, 6)
            .skipWhile { $0 < 4 }
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        // *** skipUntil: 抑制从源可观察序列发出元素，直到参考可观察序列发出元素
        print("*****skipUntil*****")
        let sourceSeq = PublishSubject<String>()
        let referenceSeq = PublishSubject<String>()
        
        sourceSeq
            .skipUntil(referenceSeq)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        // 没有条件命令 下面走不了
        sourceSeq.onNext("Cooci")
        sourceSeq.onNext("Kody")
        sourceSeq.onNext("CC")
        
        referenceSeq.onNext("Hank") // 条件一出来,下面就可以走了
        
        sourceSeq.onNext("Lina")
        sourceSeq.onNext("小雁子")
        sourceSeq.onNext("婷婷")
        
    }
    
    /// 集合控制操作符
    func testMathematicalAggregateOperators(){
        
        // *** toArray: 将一个可观察序列转换为一个数组，将该数组作为一个新的单元素可观察序列发出，然后终止
        print("*****toArray*****")
        Observable.range(start: 1, count: 10)
            .toArray()
            .subscribe { print($0) }
            .disposed(by: disposeBag)
        // *** reduce: 从一个设置的初始化值开始，然后对一个可观察序列发出的所有元素应用累加器闭包，并以单个元素可观察序列的形式返回聚合结果 - 类似scan
        print("*****reduce*****")
        Observable.of(10, 100, 1000)
            .reduce(1, accumulator: +) // 1 + 10 + 100 + 1000 = 1111
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        // *** concat: 以顺序方式连接来自一个可观察序列的内部可观察序列的元素，在从下一个序列发出元素之前，等待每个序列成功终止
        // 用来控制顺序
        print("*****concat*****")
        let subject1 = BehaviorSubject(value: "Hank")
        let subject2 = BehaviorSubject(value: "1")
        
        let subjectsSubject = BehaviorSubject(value: subject1)
        
        subjectsSubject.asObservable()
            .concat()
            .subscribe { print($0) }
            .disposed(by: disposeBag)
        
        subject1.onNext("Cooci")
        subject1.onNext("Kody")
        
        subjectsSubject.onNext(subject2)
        
        subject2.onNext("打印不出来")
        subject2.onNext("2")
        
        subject1.onCompleted() // 必须要等subject1 完成了才能订阅到! 用来控制顺序 网络数据的异步
        subject2.onNext("3")

    }
    
    /// 从可观察对象的错误通知中恢复的操作符。
    func testErrorHandlingOperators() {
        
        // **** catchErrorJustReturn
        // 从错误事件中恢复，方法是返回一个可观察到的序列，该序列发出单个元素，然后终止
        print("*****catchErrorJustReturn*****")
        let sequenceThatFails = PublishSubject<String>()
        
        sequenceThatFails
            .catchErrorJustReturn("Cooci")
            .subscribe { print($0) }
            .disposed(by: disposeBag)
        
        sequenceThatFails.onNext("Hank")
        sequenceThatFails.onNext("Kody") // 正常序列发送成功的
        sequenceThatFails.onError(self.lgError) //发送失败的序列,一旦订阅到位 返回我们之前设定的错误的预案
        
        
        // **** catchError
        // 通过切换到提供的恢复可观察序列，从错误事件中恢复
        print("*****catchError*****")
        let recoverySequence = PublishSubject<String>()
        
        sequenceThatFails
            .catchError {
                print("Error:", $0)
                return recoverySequence  // 获取到了错误序列-我们在中间的闭包操作处理完毕,返回给用户需要的序列(showAlert)
            }
            .subscribe { print($0) }
            .disposed(by: disposeBag)
        
        sequenceThatFails.onNext("Hank")
        sequenceThatFails.onNext("Kody") // 正常序列发送成功的
        sequenceThatFails.onError(lgError) // 发送失败的序列
        
        recoverySequence.onNext("CC")
        
        
        // *** retry: 通过无限地重新订阅可观察序列来恢复重复的错误事件
        print("*****retry*****")
        var count = 1 // 外界变量控制流程
        let sequenceRetryErrors = Observable<String>.create { observer in
            observer.onNext("Hank")
            observer.onNext("Kody")
            observer.onNext("CC")
            
            if count == 1 { // 流程进来之后就会过度-这里的条件可以作为出口,失败的次数
                observer.onError(self.lgError)  // 接收到了错误序列,重试序列发生
                print("错误序列来了")
                count += 1
            }
            
            observer.onNext("Lina")
            observer.onNext("小雁子")
            observer.onNext("婷婷")
            observer.onCompleted()
            
            return Disposables.create()
        }
        
        sequenceRetryErrors
            .retry()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
        
        // **** retry(_:): 通过重新订阅可观察到的序列，重复地从错误事件中恢复，直到重试次数达到max未遂计数
        print("*****retry(_:)*****")
        let sequenceThatErrors = Observable<String>.create { observer in
            observer.onNext("Hank")
            observer.onNext("Kody")
            observer.onNext("CC")
            
            if count < 5 { // 这里设置的错误出口是没有太多意义的额,因为我们设置重试次数
                observer.onError(self.lgError)
                print("错误序列来了")
                count += 1
            }
            
            observer.onNext("Lina")
            observer.onNext("小雁子")
            observer.onNext("婷婷")
            observer.onCompleted()
            
            return Disposables.create()
        }
        
        sequenceThatErrors
            .retry(3)
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
    }
    
    /// debug Rx流程操作符。
    func testDebuggingOperators() {
        // testDebugg()
        // testResourcesTotal()
    }
    
    /// debug 操作符
    func testDebugg() {
        // **** debug
        // 打印所有订阅、事件和处理。
        print("*****debug*****")
        var count = 1
        
        let sequenceThatErrors = Observable<String>.create { observer in
            observer.onNext("Hank")
            observer.onNext("Kody")
            observer.onNext("CC")
            
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
        
        sequenceThatErrors
            .retry(3)
            .debug()
            .subscribe(onNext: { print($0) })
            .disposed(by: disposeBag)
        
    }
    
    /// RxSwift.Resources.total 操作符
    func testResourcesTotal() {
        
//        // ** RxSwift.Resources.total: 提供所有Rx资源分配的计数，这对于在开发期间检测泄漏非常有用。
//        print("*****RxSwift.Resources.total*****")
//
//        print(RxSwift.Resources.total)
//
//        let subject = BehaviorSubject(value: "Cooci")
//
//        let subscription1 = subject.subscribe(onNext: { print($0) })
//
//        print(RxSwift.Resources.total)
//
//        let subscription2 = subject.subscribe(onNext: { print($0) })
//
//        print(RxSwift.Resources.total)
//
//        subscription1.dispose()
//
//        print(RxSwift.Resources.total)
//
//        subscription2.dispose()
//
//        print(RxSwift.Resources.total)
    }
    
    /// 链接操作符
    func testConnectableOperators(){
        // 连接操作符的重要性
        // testWithoutConnect()
        // testPushConnectOperators()
        // testReplayConnectOperators()
         testMulticastConnectOperators()
    }
    
    /// multicast
    func testMulticastConnectOperators(){
        
        // *** multicast : 将源可观察序列转换为可连接序列，并通过指定的主题广播其发射。
        print("*****multicast*****")
        let subject = PublishSubject<Any>()
        subject.subscribe{print("00:\($0)")}
            .disposed(by: disposeBag)
        
        let netOB = Observable<Any>.create { (observer) -> Disposable in
                sleep(2)// 模拟网络延迟
                print("我开始请求网络了")
                observer.onNext("请求到的网络数据")
                observer.onNext("请求到的本地")
                observer.onCompleted()
                return Disposables.create {
                    print("销毁回调了")
                }
            }.publish()
        
        netOB.subscribe(onNext: { (anything) in
                print("订阅1:",anything)
            })
            .disposed(by: disposeBag)

        // 我们有时候不止一次网络订阅,因为有时候我们的数据可能用在不同的额地方
        // 所以在订阅一次 会出现什么问题?
        netOB.subscribe(onNext: { (anything) in
                print("订阅2:",anything)
            })
            .disposed(by: disposeBag)
        
        _ = netOB.connect()

    }

    /// replay
    func testReplayConnectOperators(){
        
        // **** replay: 将源可观察序列转换为可连接的序列，并将向每个新订阅服务器重放以前排放的缓冲大小
        // 首先拥有和publish一样的能力，共享 Observable sequence， 其次使用replay还需要我们传入一个参数（buffer size）来缓存已发送的事件，当有新的订阅者订阅了，会把缓存的事件发送给新的订阅者
        print("*****replay*****")

        let interval = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).replay(5)
        
        interval.subscribe(onNext: { print(Date.time,"订阅: 1, 事件: \($0)") })
            .disposed(by: self.disposeBag)
        
        delay(2) { _ = interval.connect() }
        
        delay(4) {
            interval.subscribe(onNext: { print(Date.time,"订阅: 2, 事件: \($0)") })
                .disposed(by: self.disposeBag)
        }
        
        delay(8) {
            interval.subscribe(onNext: { print(Date.time,"订阅: 3, 事件: \($0)") })
                .disposed(by: self.disposeBag)
        }
        delay(20, closure: {
            self.disposeBag = DisposeBag()
        })
        
        /**
         订阅: 1, 事件: 4
         订阅: 1, 事件: 0
         2019-05-28 21-32-42 订阅: 2, 事件: 0
         2019-05-28 21-32-42 订阅: 1, 事件: 1
         2019-05-28 21-32-42 订阅: 2, 事件: 1
         2019-05-28 21-32-45 订阅: 2, 事件: 4
         2019-05-28 21-32-46 订阅: 3, 事件: 0
         2019-05-28 21-32-46 订阅: 3, 事件: 1
         2019-05-28 21-32-46 订阅: 3, 事件: 2
         2019-05-28 21-32-46 订阅: 3, 事件: 3
         2019-05-28 21-32-46 订阅: 3, 事件: 4
         
         // 序列从 0开始
         // 定时器也没有断层  sub2 sub3 和 sub1 是同步的
         */
    }
    
    /// push - connect 将源可观察序列转换为可连接序列
    func testPushConnectOperators(){
        
        // **** push:将源可观察序列转换为可连接序列
        // 共享一个Observable的事件序列，避免创建多个Observable sequence。
        // 注意:需要调用connect之后才会开始发送事件
        print("*****testPushConnect*****")

        let interval = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance).publish()
        
        interval.subscribe(onNext: { print("订阅: 1, 事件: \($0)") })
            .disposed(by: disposeBag)
        
        delay(2) {
            _ = interval.connect()
        }
        delay(4) {
            interval.subscribe(onNext: { print("订阅: 2, 事件: \($0)") })
                .disposed(by: self.disposeBag)
        }
        delay(6) {
            interval.subscribe(onNext: { print("订阅: 3, 事件: \($0)") })
                .disposed(by: self.disposeBag)
        }
        delay(10, closure: {
            self.disposeBag = DisposeBag()
        })
        /**
            订阅: 1, 事件: 1
            订阅: 2, 事件: 1
            订阅: 1, 事件: 2
            订阅: 2, 事件: 2
            订阅: 1, 事件: 3
            订阅: 2, 事件: 3
            订阅: 3, 事件: 3
         
            订阅: 2 从1开始
            订阅: 3 从3开始
        */
        // 但是后面来的订阅者，却无法得到之前已发生的事件
    }
    
    /// 没有共享序列
    func testWithoutConnect() {
        
        print("*****testWithoutConnect*****")

        let interval = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        
        interval.subscribe(onNext: { print("订阅: 1, 事件: \($0)") })
            .disposed(by: disposeBag)
        
        delay(3) {
            interval.subscribe(onNext: { print("订阅: 2, 事件: \($0)") })
                .disposed(by: self.disposeBag)
        }
        delay(10, closure: {
            self.disposeBag = DisposeBag()
        })

        // 发现有一个问题:在延时3s之后订阅的Subscription: 2的计数并没有和Subscription: 1一致，而是又从0开始了，如果想共享，怎么办?
    }
    
    /// 延迟几秒执行
    func delay(_ delay: Double, closure: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
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
