//
//  RXSwiftRestViewController.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2020/7/15.
//  Copyright © 2020 mr dk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


class RXSwiftRestViewController: UIViewController {
    
    var presentedCount = 0
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var textFiled: UITextField!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    var person:LGPerson = LGPerson()
    let disposeBag = DisposeBag()
    var timer: Observable<Int>!
    
    @IBAction func hitmeAction(_ sender: Any) {
        
        let vc = RXSwiftRestViewController.instanceController(.main)
        vc.presentedCount  = self.presentedCount + 1
        let nav = UINavigationController(rootViewController: vc)
//        vc.modalPresentationStyle = .fullScreen
        nav.modalPresentationStyle = .fullScreen
        self.navigationController?.present(nav, animated: true, completion: nil)
//        self.present(vc, animated: true, completion: nil)

    }
    @IBAction func dismissAction(_ sender: Any) {
        
//        self.dismiss(animated: true, completion: nil)
        var vc = self.presentingViewController
//        var vc = self.presentingViewController
        
        while presentedCount > 0 {
            vc = vc?.presentingViewController
            presentedCount -= 1
        }
        
        vc?.dismiss(animated: true, completion: nil)
        
//        while vc != nil  {
//            vc?.dismiss(animated: false, completion: nil)
//
//            vc = vc?.presentingViewController
//        }
//        if vc == nil {
//            self.navigationController?.dismiss(animated: true, completion: nil)
//        } else {
//            vc?.navigationController?.dismiss(animated: true, completion: nil)
//        }
//        self.navigationController?.dismiss(animated: true, completion: nil)
//        vc?.dismiss(animated: true, completion: nil)
//        vc?.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        //        setupNextwork()
        
//        setupTimer()
        //        setupNotification()
        setupGestureRecognizer()
        setupScrollerView()
        setupTextFiled()
//        setupKVO()
    }
    
    //MARK: - RxSwift应用-网络请求
    func setupNextwork() {
        
        let url = URL(string: "https://www.baidu.com")
        //        URLSession.shared.dataTask(with: url!) { (data, response, error) in
        //            print(String.init(data:data!,encoding: .utf8))
        //        }.resume()
        
        
        URLSession.shared.rx.response(request: URLRequest(url: url!))
            .subscribe(onNext: { (response: HTTPURLResponse, data: Data) in
                
                print("respone:\(response)\n data:\(data)")
                
            }).disposed(by: disposeBag)
        
    }
    
    //MARK: - RxSwift应用-timer定时器
    func setupTimer() {
        // 核心逻辑
        // 1 发送一个响应
        
        
        timer = Observable.interval(DispatchTimeInterval.seconds(1), scheduler: MainScheduler.instance)
        
        timer.subscribe(onNext: { (num) in
            print(num)
        }).disposed(by: disposeBag)
        
    }
    
    //MARK: - 通知
    func setupNotification(){
        
        
        NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .subscribe(onNext: { (noti) in
                print(noti)
            })
            .disposed(by: disposeBag)
        
    }
    
    //MARK: - 手势
    func setupGestureRecognizer() {
        
        let tap = UITapGestureRecognizer()
        self.label.addGestureRecognizer(tap)
        self.label.isUserInteractionEnabled = true
        
        tap.rx.event.subscribe(onNext: { (tap) in
            print(tap.view ?? "sdsds111")
        })
            .disposed(by: disposeBag)
        
    
    }
    
    //MARK: - RxSwift应用-scrollView
    func setupScrollerView() {
        
        scrollView.rx.contentOffset
            .subscribe(onNext: { (content) in
                
//                self?.view.backgroundColor = UIColor.init(red: content.y/255*0.8, green: content.y/255*0.6, blue: content.y/255*0.3, alpha: 1)

            })
        .disposed(by: disposeBag)
    }
    
    
    //MARK: - RxSwift应用-textfiled
    func setupTextFiled() {
        self.textFiled.rx.text.orEmpty
            .subscribe(onNext: { (text) in
               print(text)
            })
            .disposed(by: disposeBag)
     
        // 简单简单 更简单-RxSwift 面向开发者
        // 切记盲目使用
        // 太爽上瘾 - 学习 - 高级函数
        self.textFiled.rx.text
            .bind(to: self.button.rx.title())
            .disposed(by: disposeBag)
        

    }
    
    
     //MARK: - RxSwift应用-button响应
        func setupButton() {
            // 业务逻辑 和 功能逻辑
            // 设计
            
            self.button.rx.tap
    //            .subscribe(onNext: { () in
    //                print("点击来了")
    //            })
    //            .disposed(by: disposeBag)
            self.button.rx.controlEvent(.touchUpOutside)
            
//            self.button.rx.controlEvent(UIControl.Event.touchDown)
//            .subscribe(<#T##observer: ObserverType##ObserverType#>)
        }
    
    
    //MARK: - RxSwift应用-KVO
    func setupKVO() {
        // self.person.addObserver(self, forKeyPath: "name", options: .new, context: nil)
//        self.person.rx.observeWeakly(String.self, "name")
//            .subscribe(onNext: { (value) in
//                print(value as Any)
//            })
//            .disposed(by: disposeBag)
        
        person.rx.observeWeakly(String.self, "name")
            .subscribe(onNext: { (value) in
                print(value ?? "难上加难吃啥能")
            })
        .disposed(by: disposeBag)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        person.name = person.name + "你好啊"
        print("person name = \(person.name)")
    }
    
    
    deinit {
        
        print("RXSwiftRestViewController  deinit")
    }
    
}
class LGPerson: NSObject {
    @objc dynamic var name = "wink"
}
