//
//  CustomAlterViewController.swift
//  RXSwift_Explore
//
//  Created by 0608 on 2020/8/20.
//  Copyright © 2020 mr dk. All rights reserved.
//

import UIKit

class CustomAlterViewController: UIAlertController {

    var dismissReturn: (()-> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addTapMethod()
    }
    

   /// 给 UIAlertController 添加空白处点击 dismiss
    func addTapMethod() {
                
        guard let arrayViews = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.subviews else { return }
        
        if !arrayViews.isEmpty {
            let backview = arrayViews.last
            backview?.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(tapMethod))
            tap.delegate = self
            backview?.addGestureRecognizer(tap)
        }
               
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
    }

    @objc func tapMethod() {
        
        if let block = dismissReturn {
            block()
        }
        self.dismiss(animated: true, completion: nil)
    }
}

extension CustomAlterViewController: UIGestureRecognizerDelegate {
    
   
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
           let tapView = gestureRecognizer.view
           let point = touch.location(in: tapView)
           let conPoint = self.view.convert(point, from: tapView)
           
           let isContains = self.view.bounds.contains(conPoint)
           if isContains {
               return false // 单击点包含在alert区域内 不响应tap手势
           }
           return true
       }
}
