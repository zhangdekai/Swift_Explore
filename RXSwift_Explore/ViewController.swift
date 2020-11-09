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
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var textButton: UIButton!
    let bag = DisposeBag()
    
    lazy var progressView: VideoCallCycleView = {
        let cycle = VideoCallCycleView()
        cycle.frame = CGRect(x: 105, y: 34, width: 101, height: 101)
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
    
    var alterVC:CustomAlterViewController!
    
    var timerCont = 0
    
    public enum LiveType: Int {
           case single = 1
           case multi
           case dating
           
           func seatCount() -> Int {
               switch self {
               case .multi:
                   return 5
               case .dating:
                   return 6
               default:
                   return 0
               }
           }
       }
    
    class TestSortType {
        var category: Int = 0
        init(category: Int) {
            self.category = category
        }
    }
    
//    var heartImage = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "hello"
//        addBottomProgressView()
                
        
       
    }
    //MARK: - 定位测试
    var manager: LocationManager!
    @IBAction func testLocation(_ sender: Any) {
        
        if CLLocationManager.locationServicesEnabled() {
            print("设备有定位服务")
            
            manager = LocationManager.shared
            
            manager.getAuthHandle = { [weak self] (success) in
                if success {
                    
                }
                print("获取权限:\(success)")
            }
            
            if manager.hasLocationPermission() {
                

                manager.requestLocation()
                manager.getLocationHandle = { (success,latitude, longitude) in
                    
                    print("获得location \(success), latitude:\(latitude)  longitude:\(longitude)")
                }
            } else {
                manager.requestLocationAuthorizaiton()

            }
        } else {
            print("设备meiyou有定位服务")
            
            let alter = UIAlertController(title: "Location is Disabled", message: "To use location, go to your settings\nApp > Privacy > Location Services", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alter.addAction(action)
           
            present(alter, animated: true, completion: nil)
        }
        
    }
    
    //MARK: - 红心跳动
    var heartImage = UIImageView(image: UIImage(named: "vivi_videocall_match_redheart"))
    func redHeartMove() {
        view.addSubview(heartImage)
        heartImage.snp.makeConstraints { (make) in
            make.bottom.equalTo(-120)
            make.width.height.equalTo(90)
            make.centerX.equalToSuperview()
        }
        
        let k = CAKeyframeAnimation(keyPath: "transform.scale")
        k.values = [0.9, 1.0,1.1]
        k.keyTimes = [0.0, 0.2, 0.6, 0.8, 1.0]
        k.calculationMode = .linear
        k.repeatCount = 1000
        k.duration = 1.5
        heartImage.layer.add(k, forKey: "SHOW")
    }
    
    //MARK: - Sort 测试
    func testSort() {
        
        var aaa = [TestSortType(category: 1), TestSortType(category: 2), TestSortType(category: 3), TestSortType(category: 4)]
                
        aaa.sort(by: { $0.category > $1.category })
        aaa.map({ print($0.category) })
        
        let bbb = aaa.sorted(by: {$0.category > $1.category})
        bbb.map({ print($0.category) })
    }
    
    //MARK: - 多态实现
    func testABClient() {
        let client:Client = AClient()
        client.connectIm()
    
        let client1:Client = BClient()
        client1.connectIm()
        
        
        textButton.backgroundColor = .yellow
        textButton.titleLabel?.numberOfLines = 1
        textButton.titleLabel?.lineBreakMode = .byWordWrapping

        textButton.setTitle("please input hello world    ", for: .normal)
//        textButton.sizeToFit()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        progressView.timerMove()
    }
    //MARK: - 随机匹配底部弹出的倒计时View
    var botomProgressImageView: UIImageView!
    func addBottomProgressView() {
        
        addBackground()
        
        botomProgressImageView = UIImageView(image: UIImage(named: "vivi_videocall_match_limited_product"))
        view.addSubview(botomProgressImageView)
        botomProgressImageView.snp.makeConstraints { (make) in
            make.bottom.equalTo(-Frame.Height.safeAeraBottomHeight - 52)
            make.centerX.equalToSuperview()
            make.width.equalTo(311)
            make.height.equalTo(343)
        }
        
        let tap = UITapGestureRecognizer()
        botomProgressImageView.addGestureRecognizer(tap)
        botomProgressImageView.isUserInteractionEnabled = true
        tap.rx.event
            .subscribe(onNext: { [weak self] (tap) in
                self?.getCoins()
            }).disposed(by: bag)
        
        botomProgressImageView.addSubview(self.progressView)
        progressView.setTimeCount(50, showType: .withTextA)
        progressView.timerEndHandle = {[weak self] in
            //
            self?.getCoins()
        }
    }
    
    func getCoins() {
        botomProgressImageView.isHidden = true
        
    }
    
    
    func testCustomAlter() {
        
        alterVC = CustomAlterViewController(title: nil, message: "alter hello", preferredStyle: .alert)
        
        alterVC.addAction(title: "oK", style: .default, isEnabled: true) {(action) in
            
            print("hello 1")
        }
        
        self.present(alterVC, animated: true, completion: nil)
        
        alterVC.dismissReturn = {
            print("hello 1wwew")

        }
    }
    
    func testEnumFunc() {
        
        let adsd = LiveType.dating
        
        let count = adsd.seatCount()
        
        print(count)
    }

    func indexTest() {
        let array = [1,2,3,3,3,4]
        
        let ind = array.firstIndex(where: { $0 == 3})
        let lastIndex = array.lastIndex(where: { $0 == 3})

        print(ind ?? -1)
        print(lastIndex ?? -1)
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
    
    func addBackground() {
        let imageView = UIImageView(image: UIImage(named: "background"))
        view.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func addUserLeaderView() {
        addBackground()
        
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
        self.present(vc, animated: true, completion: nil)
        
//        self.navigationController?.pushViewController(vc, animated: true)
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


extension UIAlertController {
    
//    /// 给 UIAlertController 添加空白处点击 dismiss
//    func addTapDismiss() {
//
//        let arrayViews = UIApplication.shared.keyWindow?.subviews
//
//        if !(arrayViews?.isEmpty ?? true) {
//            let backview = arrayViews?.last
//            backview?.isUserInteractionEnabled = true
//            let tap = UITapGestureRecognizer(target: self, action: #selector(tapMethod))
//            tap.delegate = self
//            backview?.addGestureRecognizer(tap)
//
//        }
//    }
//
//    @objc func tapMethod() {
//        self.dismiss(animated: true, completion: nil)
//
//    }


    
    @discardableResult
    func addAction(title: String, style: UIAlertAction.Style = .default, isEnabled: Bool = true, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        action.isEnabled = isEnabled
        addAction(action)
        return action
    }
}

