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
    
    
    public static func show(){
        
        IHProgressHUD.set(defaultStyle: .dark)
        IHProgressHUD.show()
        
    }
    
    public static func show(_ status: String?){
        
        IHProgressHUD.show(withStatus: status)
        
    }
    
    public static func dismiss(_ status: String?){
        
        DispatchQueue.global(qos: .default).async(execute: {
            // time-consuming task
            IHProgressHUD.dismiss()
        })
    }
}
