//
//  BMPlayerViewController.swift
//  RXSwift_Explore
//
//  Created by 0608 on 2020/7/27.
//  Copyright © 2020 mr dk. All rights reserved.
//

import UIKit
import BMPlayer


import UIKit

struct ProgressProgerty {
    var width : CGFloat?
    var trackColor : UIColor?
    var progressColor : UIColor?
    var progressStart : CGFloat?
    var progressEnd : CGFloat?
    
    init(width:CGFloat, progressEnd:CGFloat, progressColor:UIColor) {
        self.width = width
        self.progressEnd = progressEnd
        self.progressColor = progressColor
        trackColor = UIColor.gray
        progressStart = 0.0
    }
    
    init() {
        width = 5
        trackColor = UIColor.gray
        progressColor = UIColor.red
        progressStart = 0.0
        progressEnd = 1
    }
    
}

class BMPlayerViewController: UIViewController {
    
    private var playerView: BMPlayerLayerView!
    
    private var urlString: String = "https://s3.cuddlelive.com/da/99/4e/e8c8984bdbaff8991c240d9777.mp4"
    
    init(_ urlString:String) {
        super.init(nibName: nil, bundle: nil)
//        self.urlString = urlString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViews()
        
        playerView.playURL(url: URL(string: urlString)!)
        
        addNotification()
    }
    
    func configureViews() {
        self.playerView = BMPlayerLayerView(frame: CGRect.zero)
        view.addSubview(playerView)
        playerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
       
    }
    
    
    
    func addNotification() {
        NotificationCenter.default.addObserver(self,
                                                 selector: #selector(applicationDidEnterBackground),
                                                 name: UIApplication.didEnterBackgroundNotification,
                                                 object: nil)
          
          NotificationCenter.default.addObserver(self,
                                                 selector: #selector(applicationWillEnterForeground),
                                                 name: UIApplication.willEnterForegroundNotification,
                                                 object: nil)
    }
        
    @objc func applicationDidEnterBackground() {
        playerView.pause()
    }
    @objc func applicationWillEnterForeground() {
        if !playerView.isPlaying {
            playerView.play()
        }
    }
}

extension UIButton {
    /*
    func refreshRightLeft() {
        
        let ivW:CGFloat = self.imageView?.frame.size.width
        let titW: CGFloat = self.titleLabel?.frame.size.width
        
        let t1: CGFloat = 0
        let l1: CGFloat = titW
        let b1: CGFloat = -t1
        let r1: CGFloat = -l1
        self.imageEdgeInsets = UIEdgeInsets(top: t1, left: l1, bottom: b1, right: r1)

        let t2: CGFloat = 0
        let l2: CGFloat = -ivW
        let b2: CGFloat = -t2
        let r2: CGFloat = -l2
        
    }
    - (void)refreshRightLeft{
       
        self.imageEdgeInsets=UIEdgeInsetsMake(t1,l1,b1,r1);
        
        CGFloat t2=0;
        CGFloat l2=-ivW;
        CGFloat b2=-t2;
        CGFloat r2=-l2;
        self.titleEdgeInsets=UIEdgeInsetsMake(t2,l2,b2,r2);
    }
 */
}
