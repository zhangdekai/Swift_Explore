//
//  TestCuddeleViewController.swift
//  RXSwift_Explore
//
//  Created by 0608 on 2020/7/29.
//  Copyright © 2020 mr dk. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: 金币View
class UserCoinCountView: UIView {
    
    lazy var button = UIButton()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4).cgColor
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 21
        
        button.setTitle("180", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.textAlignment = .right
        self.addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.centerY.equalToSuperview()
        }
        
        let image = UIImageView(image: UIImage(named: "vivichat_coins_icoon"))
        self.addSubview(image)
        image.snp.makeConstraints { (make) in
            make.left.equalTo(button.snp.right).offset(10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(30)
            make.right.equalTo(-12)
        }
        
        let label = UILabel()
        self.addSubview(label)
        
    }
    
    func setCoinsCount(_ num: String) {
        button.setTitle(num, for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

/// 圆环倒计时
class VideoCallCycleView: UIView {
    
    enum ShowType {
        /// show 60, 59,
        case withText
        /// no text show
        case withoutText
        /// show 00:50 -> 00:49
        case withTextA
    }
    
    var timerEndHandle: (() -> Void)?
    var tapHandle: (() -> Void)?
    /// 线宽
    var progressWidth: CGFloat = 10
    /// 底线
    var bottomColor: UIColor?
    /// progress线条
    var topColor: UIColor?
    
    private var roundOrigin: CGPoint = CGPoint(x: 0, y: 0)//圆点
    private var radius: CGFloat = 0//半径
    private var startAngle: CGFloat = 0//起始
    private var endAngle: CGFloat = 0//结束
    
    private var blocks: ((_ progressfloat: CGFloat) -> Void)?
    
    private var _timer: Timer?
    private var timeOut = 60
    private var step = 1.0//0.01 * (100.0 / 60.0)
    private var showType: ShowType = .withText
    
    //进度 展示label
    private lazy var progressLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = UIColor.white
        lab.font = .systemFont(ofSize: 13)
        lab.textAlignment = .center
        return lab
    }()
    private lazy var bottomLayer: CAShapeLayer = {
        let layers = CAShapeLayer()
        layers.fillColor = UIColor.clear.cgColor
        return layers
    }()
    private lazy var topLayer: CAShapeLayer = {
        let layers = CAShapeLayer()
        layers.lineCap = CAShapeLayerLineCap.round
        layers.fillColor = UIColor.clear.cgColor
        return layers
    }()
    
    var topTitle: UILabel!
    var bottomTitle: UILabel!
    var anmationDuration = 1.0
    
//    func setProductInfo(_ info: [Entity.VideoCall.RecommendProduct]) {
//        if !info.isEmpty {
//            topTitle.text = info[0].amount.string
//            bottomTitle.text = "$ \(Double(info[0].price) / 100.0 )"
//        }
//    }
    
    func setTimeCount(_ time: Int, showType: ShowType) {
        self.showType = showType
        switch showType {
        case .withoutText:
            progressLabel.isHidden = true
        case.withTextA:
            progressLabel.text = "00:\(time)"
            progressLabel.font = .systemFont(ofSize: 25, weight: .medium)
        default:
            break
        }
        
        anmationDuration = Double(time)
        self.timeOut = time
        
    }
    
    func timerMove() {
        beginTimer()
        drawRing(profloat: 1.0)
    }
    
    private func beginTimer() {
        _timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        RunLoop.main.add(_timer!, forMode: .common)
    }
    
    func addTimer() {
        timeOut = 60
        _timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        RunLoop.main.add(_timer!, forMode: .common)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            if self.blocks != nil {
                self.blocks!(1.0)
            }
        }
    }
    
    func addTimerA() {
        timeOut = 25
        progressLabel.isHidden = true
        _timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        RunLoop.main.add(_timer!, forMode: .common)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            if self.blocks != nil {
                self.blocks!(1.0)
            }
        }
    }
    
    @objc func timerAction() {
        timeOut -= 1
        switch showType {
        case.withText:
            progressLabel.text = "\(timeOut)"
        case.withTextA:
            if timeOut < 10 {
                progressLabel.text = "00:0\(timeOut)"
            } else {
                progressLabel.text = "00:\(timeOut)"
            }
        default:
            break
        }

        if timeOut <= 0 {
            if let block = self.timerEndHandle {
                block()
            }
            removeTimer()
        }
    }
    
    func removeTimer() {
        if _timer != nil {
            if _timer!.isValid {
                _timer?.invalidate()
                _timer = nil
            }
        }
    }
    deinit {
        removeTimer()
    }
    
//    func addProductUI() {
//
//        let image = UIImageView(image: R.image.vivi_coin())
//        self.addSubview(image)
//        image.snp.makeConstraints { (make) in
//            make.left.equalTo(30)
//            make.top.equalTo(12)
//            make.width.height.equalTo(18)
//        }
//        image.isUserInteractionEnabled = true
//        let tap = UITapGestureRecognizer(target: self, action: #selector(tapMethod))
//        image.addGestureRecognizer(tap)
//
//        let label = UILabel()
//        self.topTitle = label
//        label.textColor = UIColor.white
//        label.font = .systemFont(ofSize: 14)
//        self.addSubview(label)
//        label.snp.makeConstraints { (make) in
//            make.left.equalTo(image.snp.right).offset(3)
//            make.centerY.equalTo(image)
//            make.height.equalTo(20)
//        }
//
//        let label1 = UILabel()
//        self.bottomTitle = label1
//        label1.textColor = UIColor.white
//        label1.font = .systemFont(ofSize: 14)
//        self.addSubview(label1)
//        label1.snp.makeConstraints { (make) in
//            make.height.equalTo(20)
//            make.centerX.equalToSuperview()
//            make.bottom.equalTo(-12)
//        }
//    }
    
    @objc func tapMethod() {
        if let block = tapHandle {
            block()
        }
    }
    
    override func draw(_ rect: CGRect) {
        
        setUPUI()
        addRound()
        setMethoud()
    }
    
    
    func drawRing(profloat: CGFloat) {
        self.startAngle = -CGFloat(Double.pi / 2)
        
        self.endAngle = self.startAngle + profloat * CGFloat(Double.pi * 2)
        
        let topPath = UIBezierPath(arcCenter: self.roundOrigin, radius: self.radius, startAngle: self.startAngle, endAngle: self.endAngle, clockwise: true)
        
        self.topLayer.path = topPath.cgPath//添加路径
        //添加动画
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.isRemovedOnCompletion = false
        pathAnimation.duration = self.anmationDuration //动画持续时间
        pathAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        pathAnimation.fromValue = 1
        pathAnimation.toValue = 0
        self.topLayer.add(pathAnimation, forKey: "strokeEndAnimation")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUPUI() {
        
        layer.addSublayer(bottomLayer)
        layer.addSublayer(topLayer)
        addSubview(progressLabel)
        progressLabel.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.center.equalToSuperview()
        }
    }
    func addRound() {
        roundOrigin = CGPoint(x: self.bounds.size.width / 2, y: self.bounds.size.height / 2)
        radius = self.bounds.size.width / 2
        let bottomPath = UIBezierPath(arcCenter: roundOrigin, radius: radius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
        bottomLayer.path = bottomPath.cgPath
    }
    func setMethoud() {
        bottomLayer.strokeColor = bottomColor?.cgColor
        topLayer.strokeColor = topColor?.cgColor
        topLayer.lineWidth = progressWidth
        bottomLayer.lineWidth = progressWidth
    }
}


class TestCuddeleViewController: UIViewController {

    
 override func viewDidLoad() {
    super.viewDidLoad()
    
    
    
    }
}

class TestCuddeleViewController12: UIViewController, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let textfiled = UITextField()
        view.addSubview(textfiled)
        textfiled.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(60)
            make.height.equalTo(30)
        }
        textfiled.placeholder = "请输入要呼叫的 UID"
        
        textfiled.delegate = self
        
        let font = UIFont(name: "Avenir Medium", size: 20)
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let num = textField.text ?? "903586"
        
        return true
    }
}

class TestCuddeleViewController2: UIViewController {
    
    var confirmButonHandle: (() -> Void)?
//    var cameraAuthHandle: (() -> Void)?
//    var microAuthHandle: (() -> Void)?

    lazy var userImageView = UIImageView()
    lazy var msgLabel = UILabel()
    lazy var confirmButton = UIButton()
    lazy var authview = AuthSelectItem()
    lazy var authview1 = AuthSelectItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let container = UIView()
        container.layer.masksToBounds = true
        container.layer.cornerRadius = 24
        container.backgroundColor = UIColor.white
        view.addSubview(container)
        container.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 315.scalValue, height: 338.scalValue))
        }
        
        let titleLabel = UILabel()
        container.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(20.scalValue)
            make.height.equalTo(27.5.scalValue)
        }
        titleLabel.text = "Almost done!"
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Avenir Black", size: 20)

        
        let subtitleLabel = UILabel()
        container.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10.scalValue)
            make.height.equalTo(24.scalValue)
        }
        subtitleLabel.text = "Enable microphone and camera"
        subtitleLabel.numberOfLines = 1
        subtitleLabel.textAlignment = .center
        subtitleLabel.font = UIFont(name: "Avenir Black", size: 16)

       
        
        let button = UIButton()
        self.confirmButton = button
        container.addSubview(button)
        button.frame = CGRect(x: 20.scalValue, y: 240.scalValue, width: 275.scalValue, height: 58.scalValue)
        
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 29.scalValue
        button.backgroundColor = UIColor.green
        button.setTitle("Okay", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        
        confirmButton.rx.tap
            .subscribe(onNext: {[weak self] in
                guard let `self` = self else { return }
                if let block = self.confirmButonHandle {
                    block()
                }
            })
        
        container.addSubview(authview)
        authview.snp.makeConstraints { (make) in
            make.top.equalTo(subtitleLabel.snp.bottom).offset(30.scalValue)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        authview.setUI("vivichat_camera_icon", title: "Camera")
        authview.selectButton.rx.tap
            .subscribe(onNext: {[weak self] in
                guard let `self` = self else { return }
                self.requestCameraAuth()
            })
        
        container.addSubview(authview1)
        authview1.snp.makeConstraints { (make) in
            make.top.equalTo(self.authview.snp.bottom).offset(10.scalValue)
            make.left.right.equalToSuperview()
            make.height.equalTo(50)
        }
        authview1.setUI("vivichat_appAuth_micro_cion", title: "Microphone")
        
        authview1.selectButton.rx.tap
        .subscribe(onNext: {[weak self] in
            guard let `self` = self else { return }
            self.requestMicrophoneAuth()
        })

    }
    
    func requestCameraAuth(){
        
    }
    func requestMicrophoneAuth(){
        
    }
    
    class AuthSelectItem: UIView {
        var icon = UIImageView()
        var titleLabel = UILabel()
        var selectButton = UIButton()
        override init(frame: CGRect) {
            super.init(frame: frame)
            
            self.addSubview(icon)
            icon.snp.makeConstraints { (make) in
                make.left.equalTo(43.scalValue)
                make.size.equalTo(CGSize(width: 18.scalValue, height: 18.scalValue))
                make.top.equalTo(10.scalValue)
                
            }
            
            self.addSubview(titleLabel)
            titleLabel.snp.makeConstraints { (make) in
                make.left.equalTo(self.icon.snp.right).offset(5.scalValue)
                make.centerY.equalTo(self.icon.snp.centerY)
            }
            titleLabel.font = UIFont(name: "Avenir Medium", size: 20)
            
            self.addSubview(selectButton)
            selectButton.snp.makeConstraints { (make) in
                make.right.equalTo(-40.scalValue)
                make.centerY.equalTo(self.titleLabel.snp.centerY)
                make.size.equalTo(CGSize(width: 24.scalValue, height: 24.scalValue))
            }
            selectButton.backgroundColor = UIColor.gray
        }
        
        func setUI(_ iconName: String, title: String) {
            icon.image = UIImage(named: iconName)
            titleLabel.text = title
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

class TestCuddeleViewController1: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageview = UIImageView()
        view.addSubview(imageview)
        imageview.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        imageview.image = UIImage(named: "background")
        
        let layerView = UIView()
        layerView.frame = CGRect(x: 20, y: 40, width: 335, height: 62)
        view.addSubview(layerView)
        
        
        layerView.backgroundColor = UIColor.black
        layerView.alpha = 0.4
        layerView.layer.masksToBounds = true
        layerView.layer.cornerRadius = 31
        
        let label = UILabel()
        layerView.addSubview(label)
        label.text = "You’ll be charged 120 coins per minute."
        label.textColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 14)
        label.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalTo(10)
            make.right.equalTo(-85)
        }
        
        
    }
    
    
    // MARK: CallConnectTopView
    class CallConnectTopView: UIView {
        
        override init(frame: CGRect) {
            super.init(frame: CGRect.zero)
            
            let layerView = UIView()
            layerView.frame = CGRect(x: 20, y: 40, width: 335, height: 62)
            
            let bgLayer1 = CALayer()
            bgLayer1.frame = layerView.bounds
            bgLayer1.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
            layerView.layer.addSublayer(bgLayer1)
            self.addSubview(layerView)
            
            let label = UILabel()
            let attrString = NSMutableAttributedString(string: "You’ll be charged 120 coins per minute.")
            label.frame = CGRect(x: 30, y: 62, width: 239, height: 19)
            label.numberOfLines = 0
            let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "Avenir Medium", size: 14),.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
            attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
            label.textColor = UIColor.blue
            label.backgroundColor = UIColor.white
            label.attributedText = attrString
            self.addSubview(label)
            
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        lazy var layerView: UIView = {
            let layerView = UIView()
            layerView.frame = CGRect(x: 20, y: 40, width: 335, height: 62)
            
            let bgLayer1 = CALayer()
            bgLayer1.frame = layerView.bounds
            bgLayer1.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
            layerView.layer.addSublayer(bgLayer1)
            self.addSubview(layerView)
            
            let label = UILabel()
            let attrString = NSMutableAttributedString(string: "You’ll be charged 120 coins per minute.")
            label.frame = CGRect(x: 30, y: 62, width: 239, height: 19)
            label.numberOfLines = 0
            let attr: [NSAttributedString.Key : Any] = [.font: UIFont(name: "Avenir Medium", size: 14),.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 1)]
            attrString.addAttributes(attr, range: NSRange(location: 0, length: attrString.length))
            label.textColor = UIColor.blue
            label.backgroundColor = UIColor.white
            label.attributedText = attrString
            self.addSubview(label)
            
            return layerView
        }()
    }
    
}


class UserLeadWordView: UIView {
        
    var sendWordHandle: ((String) -> Void)?
    private var cellIdentifier = "UserLeadWordCollectionViewCell"
    private lazy var collectView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 6
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize

        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 18
        
        view.register(UserLeadWordCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        view.contentInset = UIEdgeInsets(top: 0, left: 6, bottom: 0, right: 0)
        view.showsHorizontalScrollIndicator = false
        
        view.backgroundColor = UIColor.clear
        
        return view
    }()

    private var dataSource = [String]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.frame = CGRect(x: 0, y: 0, width: 336, height: 36)
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)

        addSubview(self.collectView)
        collectView.delegate = self
        collectView.dataSource = self
        collectView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        
        
    }
    
    func setWords() {
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension UserLeadWordView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as!UserLeadWordCollectionViewCell
        
        cell.updateCell("Hi～ I’m a new comer!")
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        return CGSize(width: 0.01, height: 24)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let block = self.sendWordHandle {
//            block(dataSource[indexPath.row])
        }
    }

}


class UserLeadWordCollectionViewCell: UICollectionViewCell {
    
    var contentLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 12
        
//        self.backgroundView?.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.15)
        self.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.15)
        
        
        contentLabel = UILabel()
        self.addSubview(contentLabel)
        contentLabel.textColor = .white

        contentLabel.font = .systemFont(ofSize: 14)
        contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(8)
            make.right.equalTo(-8)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
    }
    
    func updateCell(_ text: String) {
        contentLabel.text = text
        contentLabel.sizeToFit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
