//
//  BMPlayerViewController.swift
//  RXSwift_Explore
//
//  Created by 0608 on 2020/7/27.
//  Copyright © 2020 mr dk. All rights reserved.
//

import UIKit
import BMPlayer

class BMPlayerViewController: UIViewController {
    
    private var playerView: BMPlayerLayerView!
    
    private var urlString: String = ""
    
    init(_ urlString:String) {
        super.init(nibName: nil, bundle: nil)
        self.urlString = urlString
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
