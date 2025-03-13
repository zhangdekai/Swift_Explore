//
//  LoadingUntil.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2025/3/10.
//  Copyright © 2025 mr dk. All rights reserved.
//

import Foundation
import IHProgressHUD /// https://github.com/Swiftify-Corp/IHProgressHUD


class LoadingUntil {
    
    static func config(){
        
        IHProgressHUD.set(defaultStyle: .custom)
        IHProgressHUD.set(foregroundColor: .blue)
        IHProgressHUD.set(defaultMaskType: .clear)
        IHProgressHUD.set(minimumSize: CGSize(width: 100, height: 100))
        IHProgressHUD.setHUD(backgroundColor: .gray.withAlphaComponent(0.1))
    }
    
    
    public static func show(){
        config()
       
        IHProgressHUD.show()
        
    }
    
    public static func show(_ status: String?){
        
        config()
        
        IHProgressHUD.show(withStatus: status)
        
}
    
    public static func dismiss(){
        
        DispatchQueue.global(qos: .default).async(execute: {
            // time-consuming task
            IHProgressHUD.dismiss()
        })
    }
}
