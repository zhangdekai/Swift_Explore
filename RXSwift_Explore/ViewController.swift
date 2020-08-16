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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "hello"
        
        
//        let imageView = UIImageView(image: UIImage(named: "background"))
//        view.addSubview(imageView)
//        imageView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
//        }
//
//        view.addSubview(self.userLeaderView)
//        userLeaderView.snp.makeConstraints { (make) in
//            make.left.equalTo(12)
//            make.right.equalTo(-12)
//            make.height.equalTo(36)
//            make.bottom.equalTo(-152 - 0)
//        }
        
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
        
        //        let vc = LoginViewController.instanceController(.main)
        
        let vc = BMPlayerViewController("")
        
        //        let vc = TestCuddeleViewController()
        self.present(vc, animated: true, completion: nil)
        
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
