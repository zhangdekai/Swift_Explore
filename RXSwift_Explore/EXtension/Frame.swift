//
//  Frame.swift
//  Cuddle
//
//  Created by Marry on 2019/6/19.
//  Copyright © 2019 Guru. All rights reserved.
//

import Foundation
import DeviceKit

struct Frame {
    /// 屏幕相关
    struct Screen {
        static let width = UIScreen.main.bounds.size.width
        static let height = UIScreen.main.bounds.size.height
        static let bounds = UIScreen.main.bounds
    }
    
    struct Height {
        
        static var isXStyle: Bool {
            let xStyleDevices: [Device] = [
                .iPhoneX,
                .iPhoneXS,
                .iPhoneXSMax,
                .iPhoneXR,
                .iPhone11,
                .iPhone11Pro,
                .iPhone11ProMax,
                .simulator(.iPhoneX),
                .simulator(.iPhoneXS),
                .simulator(.iPhoneXSMax),
                .simulator(.iPhoneXR),
                .simulator(.iPhone11),
                .simulator(.iPhone11Pro),
                .simulator(.iPhone11ProMax),
            ]
            return xStyleDevices.contains(Device.current)
        }
        
        static var safeAeraTopHeight: CGFloat {
            return isXStyle ? 44: 20
        }
        
        static var safeAeraBottomHeight: CGFloat {
            return isXStyle ? 34: 0
        }
        
        static var bottomBar: CGFloat {
            return 49 + safeAeraBottomHeight
        }
        
        static var navigation: CGFloat {
            return isXStyle ? 88: 64
        }
        
        static var statusBar: CGFloat {
            return UIApplication.shared.statusBarFrame.height
        }
        
        static var deviceDiagonalIsMinThan4_7: Bool {
            return deviceDiagonalIsMinThan(4.7)
        }
        
        static var deviceDiagonalIsMinThan5_5: Bool {
            return deviceDiagonalIsMinThan(5.5)
        }
        
        //iphonex
        static var deviceDiagonalIsMinThan6_1: Bool {
            return deviceDiagonalIsMinThan(6.1)
        }
        
        static func deviceDiagonalIsMinThan(_ value: Double) -> Bool {
            let diagonal = Device.current.diagonal
            var realDiagonal: Double {
                guard !(Device.allPads.contains(Device.current) || Device.allSimulatorPads.contains(Device.current)) else {
                    return 4.0
                }
                guard Device.current.isZoomed ?? false else {
                    return diagonal
                }
                switch diagonal {
                case 6.8:
                    return 6.5
                case 6.5:
                    return 6.1
                case 6.1:
                    return 5.8
                case 5.5:
                    return 4.7
                case 4.7:
                    return 4
                case 4:
                    return 3.5
                default:
                    return 4
                }
            }
            return realDiagonal < value
        }

    }
    
    /// 比例
    struct Scale {
        /// scale width
        static func width(_ origin: CGFloat) -> CGFloat {
            return Frame.Screen.width * origin / 375.0
        }
        /// scale height
        static func height(_ origin: CGFloat) -> CGFloat {
            return Frame.Screen.height * origin / 667.0
        }
        /// size rectangle
        static func size(_ originWidth: CGFloat, _ originHeight: CGFloat) -> CGSize {
            return CGSize(width: width(originWidth), height: height(originHeight))
        }
        /// size square
        static func size(_ origin: CGFloat) -> CGSize {
            return CGSize(width: width(origin), height: width(origin))
        }
    }
    
    struct CornerRadius {
        static let message: CGFloat = 12
    }
    
}
