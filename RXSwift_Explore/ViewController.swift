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
import MediaPlayer

let ScreenW = UIScreen.main.bounds.width
let ScreenH = UIScreen.main.bounds.height

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
    
    lazy var realPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 17, weight: .black)
        return label
    }()
    
    lazy var realPriceView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 18
        return view
    }()
    
    lazy var fixedPriceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
            
    //MARK: - life clycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var size: CGSize
        
        if #available(iOS 13.0, *) {
            size = UIApplication.shared.windows.first(where: {$0.isKeyWindow})?.windowScene?.statusBarManager?.statusBarFrame.size ?? CGSize.zero
        } else {
            size = UIApplication.shared.statusBarFrame.size
        }
        
        print("statusBar height is \(size.height)")
    
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear")
    }
    
    func testDatePicker() {
        let picker = DatePickerView()
        picker.backgroundColor = .black
        view.addSubview(picker)
        picker.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(320)
        }
        picker.selectToday()
    }
    
    // MARK: - add string at index
    
    func testStringAdd() {
        var a = "19921007"
        
        a.addString("/", at: 4)
        a.addString("/", at: 7)
    }
    
    //MARK: - 设置系统音量
    func testVolume() {
        let volumeView = MPVolumeView()
        volumeView.showsVolumeSlider = false
        if let slider = volumeView.subviews.first as? UISlider {
            DispatchQueue.main.async {
                slider.setValue(0.3, animated: false)
            }
            print("设置声音...")
        }
    }
    
    // MARK: - 带蒙层的&上下移动动画的View
    func testUpDownCoverView() {
        addBackground()
        
        let coverView = ClubStoryCoverView()
        view.addSubview(coverView)
        coverView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - 带图片属性字符串
    func testImageWord() {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(named: "vivi_recharge_user_coin")
        imageAttachment.bounds = CGRect(x: 0, y: -4, width: 24, height: 24)
        let imageAtts = NSAttributedString(attachment: imageAttachment)
        let attr = NSMutableAttributedString(string: "吉林省的能")
        attr.insert(imageAtts, at: 0)
        
        let nameLabel = UILabel(frame: CGRect(x: 100, y: 400, width: 200, height: 30))
        view.addSubview(nameLabel)
        nameLabel.attributedText = attr
    }
    
    //MARK: - bannerView
    
    func testBannerView() {
        let banner = VideoPhotoBannerView()
        
        view.addSubview(banner)
        banner.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
            make.height.equalTo(375)
        }
         
    }
    
    //MAR: - test 定时器
    func testRxTime() {
        print("addBottomProgressView111")
        Observable<Int>.interval(.seconds(5), scheduler: SerialDispatchQueueScheduler(qos: .default))
            .startWith(0)
            .subscribe(onNext: { _ in
                print("addBottomProgressView")
            })
            .disposed(by: bag)
    }
    
    
    //MARK: - 定位测试
    ///PS: LocationManager需要全局设置，否则获取权限的弹窗会闪现消失
    var manager: LocationManager!
    @IBAction func testLocation(_ sender: Any) {
        
        
        manager = LocationManager.shared
        
        if (manager.hasLocationPermission()) {
            
            print("设备有权限")

        } else {
            print("设备没有有权限")

        }
        
        
        if manager.hasLocationService() {
            print("设备有定位服务")
            
            
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
            print("设备没有定位服务")
            
            let alter = UIAlertController(title: "Location is Disabled", message: "To use location, go to your settings\nApp > Privacy > Location Services", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            let action1 = UIAlertAction(title: "Setting", style: .default) { (action) in
                if let url = URL(string: "App-Prefs:root=Privacy") {
                    UIApplication.shared.canOpenURL(url)
                    UIApplication.shared.open(url)
                }
            }
            alter.addAction(action)
            alter.addAction(action1)
           
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
    
    //MARK: - Custom Alter 测试
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
    
    //MARK: - 用户引导提示语
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
        
        delay(3) {


        }
        
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

