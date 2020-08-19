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
import SnapKit

class ViewController: UIViewController {
    
    lazy var progressView: VideoCallCycleView = {
        let cycle = VideoCallCycleView()
        cycle.frame = CGRect(x: 200, y: 400, width: 52, height: 52)
        cycle.topColor = UIColor.green
        cycle.bottomColor = UIColor.gray
        cycle.anmationDuration = 5.0
        cycle.progressWidth = 3.0
        return cycle
    }()
    lazy var rejectButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "huanfu"), for: .normal)
        button.setTitle("Decline", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 100, left: -80, bottom: 0, right: 0)
        return button
    }()
    
    var _timer: Timer!
    
    lazy var userLeaderView = UserLeadWordView()
    var randomTimer: SwiftTimer?
    
    var timerCont = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "hello"
        
       
    }
    
    func addTimerTest() {
        print("SwiftTimer begine")
        
        // 每秒。。。。
        randomTimer = SwiftTimer(interval: .seconds(1), repeats: true, queue: .main, handler: { (timer) in
            
            self.timerCont += 1
            print("SwiftTimer_____\(self.timerCont)")
            
        })
        // 3秒后 。。。。
//        randomTimer = SwiftTimer(interval: .seconds(3), handler: {[weak self] (timer) in
//            print("SwiftTimer_____")
//        })
        randomTimer?.start()
    }
    
    func addBackgroundViewAndProgress() {
        let imageView = UIImageView(image: UIImage(named: "background"))
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(self.userLeaderView)
        userLeaderView.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.right.equalTo(-12)
            make.height.equalTo(36)
            make.bottom.equalTo(-152 - 0)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        //        回调圆的比例 值为0-1
//        if self.progressView.blocks != nil {
//            self.progressView.blocks!(0.88)
//        }
        
    }

    @IBAction func subjectAction(_ sender: Any) {
        
        let vc = SubjectTestViewController.instanceController(.main)
        
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    @IBAction func jumpToFRP(_ sender: Any) {
        let vc =  FRPTestViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func jumpToShiLi(_ sender: Any) {
        
        //ps: storyboard 创建的VC 都需要使用下面来alloc vc
        let vc = RXSwiftRestViewController.instanceController(.main)
        let nav = UINavigationController(rootViewController: vc)
        
        nav.modalPresentationStyle = .fullScreen

        self.navigationController?.present(nav, animated: true, completion: nil)
//        self.present(nav, animated: true, completion: nil)
    }
    
    @IBAction func jumpLoginVC(_ sender: Any) {
        
        let vc = TestAViewController()
//        let vc = LoginViewController.instanceController(.main)
//        self.present(vc, animated: true, completion: nil)
        
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func jumpObserable(_ sender: Any) {
        
        let vc = ObservableTestViewController()
        
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func jumpOperation(_ sender: Any) {
        
        let vc = OperationtestViewController()
        self.present(vc, animated: true, completion: nil)
    }
    
    
}

extension UIViewController: LoadStoryBoard {
    
}
