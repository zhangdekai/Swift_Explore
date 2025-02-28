//
//  DeviceAuthManager.swift
//  RXSwift_Explore
//
//  Created by 0608 on 2020/8/3.
//  Copyright © 2020 mr dk. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

struct DeviceAuthManager {
    
    /// 检测麦克风权限
    static func checkMicroPhoneAuthority() -> Bool {
        
        let status = AVAudioSession.sharedInstance().recordPermission
        if status == .granted {
            return true
        }
       return false
    }
    
    /// 获取麦克风权限
    static func getMicrophonePermission(from currentVC: UIViewController) {
        weak var welf = currentVC
        
        AVAudioSession.sharedInstance().requestRecordPermission { isOpen in
            if !isOpen {
                
                DeviceAuthManager.getCameraAuth(from: currentVC)
                
                
            }
//            else {
//                DispatchQueue.main.async {
//                    completion()
//                }
//            }
        }
    }
    
    /// 获取摄像头访问权限
    static func checkCamerAuthority() -> Bool {
        let videAuthStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch videAuthStatus {
        case .authorized:
            return true
        default:
            return false
        }
    }
    
   static func getCameraAuth(from VC: UIViewController) {

        let alertVC = UIAlertController(title: "ViViChat would like to take a video", message: "Please switch on camera and microphone permission", preferredStyle: .alert)
        let resetAction = UIAlertAction(title: "Go Settings", style: .default, handler: { (_) in
            if let url = URL(string: UIApplication.openSettingsURLString),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertVC.addAction(cancelAction)
        alertVC.addAction(resetAction)
    
    VC.present(alertVC, animated: true, completion: nil)
    

//        VC.navigationController?.present(alertVC, animated: true)

    }
    
    /// 去获取相机权限
    static func getCameraAuth1313(from currentVC: UIViewController) {
        
        weak var weakSelf = currentVC
        let gotoSettingAlert = {
            
            let alertVC = UIAlertController(title: "ViViChat would like to take a video", message: "Please switch on camera and microphone permission", preferredStyle: .alert)
            let resetAction = UIAlertAction(title: "Go Settings", style: .default, handler: { (_) in
                if let url = URL(string: UIApplication.openSettingsURLString),
                    UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertVC.addAction(cancelAction)
            alertVC.addAction(resetAction)
            DispatchQueue.main.async {
                weakSelf?.navigationController?.present(alertVC, animated: true)
            }
        }
        
        // 去获取相机权限
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (success) in
            DispatchQueue.main.async {
                if success {
                    print("获取成功")
                } else {
                    gotoSettingAlert()
                }
            }
        })
    }
}
