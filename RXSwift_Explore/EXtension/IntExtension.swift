//
//  IntExtension.swift
//  Castbox
//
//  Created by ChenDong on 2017/8/15.
//  Copyright © 2017年 Guru. All rights reserved.
//

import Foundation
import UIKit

extension Int {
    var string: String {
        return String(self)
    }
    var int32: Int32 {
        return Int32(self)
    }
    
    var uInt32: UInt32 {
        return UInt32(self)
    }
    
    var int64: Int64 {
        return Int64(self)
    }
    
    var numberValue: NSNumber {
        return NSNumber(value: self)
    }
    /// 返回根据屏幕缩放后的尺寸
    var scalValue: CGFloat {
        let scal = UIScreen.main.bounds.size.width / 375.0
        return scal * CGFloat(self)
    }
    /// 返回根据屏幕缩放后的尺寸
    var scalHValue: CGFloat {
        let scal = UIScreen.main.bounds.size.height / 667.0
        return scal * CGFloat(self)
    }
}

extension UInt {
    var string: String {
        return String(self)
    }
    
    var int: Int {
        return Int(self)
    }
    
    var int32: Int32 {
        return Int32(self)
    }
    
    var uInt32: UInt32 {
        return UInt32(self)
    }
    
    var int64: Int64 {
        return Int64(self)
    }
    
    var numberValue: NSNumber {
        return NSNumber(value: self)
    }
}

extension Int32 {
    var int: Int {
        return Int(self)
    }
    
    var string: String {
        return String(self)
    }

}

extension UInt32 {
    var int: Int {
        return Int(self)
    }
    
    var string: String {
        return String(self)
    }

}

extension Optional where Wrapped == Int {
    
    var stringValue: String {
        switch self {
        case .some(let num):
            return String(num)
        default:
            return ""
        }
    }
}
// MARK: -  ps: height = 15.0.scalValue
public extension Double {
    /// 返回根据屏幕缩放后的尺寸
    var scalValue: CGFloat {
        let scal = UIScreen.main.bounds.size.width / 375.0
        return scal * CGFloat(self)
    }
}

// MARK: -  ps: height = 15.0.scalValue
public extension CGFloat {
    /// 返回根据屏幕缩放后的尺寸
    var scalValue: CGFloat {
        let scal = UIScreen.main.bounds.size.width / 375.0
        return scal * CGFloat(native)
    }
}
extension Double {
    
    func getTwoFloat() -> String {
        let d = self
        return String(format: "%.2f", d)
    }
    
}
extension Float {
    
    func getTwoFloat() -> String {
        let d = self
        return String(format: "%.2f", d)
    }
}
