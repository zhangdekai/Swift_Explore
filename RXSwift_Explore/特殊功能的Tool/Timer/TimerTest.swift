//
//  TimerTest.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2021/7/13.
//  Copyright © 2021 mr dk. All rights reserved.
//

import UIKit

class TimerTest: NSObject {

}

extension Timer {

    /// Timer将userInfo作为callback的定时方法
    /// 目的是为了防止Timer导致的内存泄露
    /// - Parameters:
    ///   - timeInterval: 时间间隔
    ///   - repeats: 是否重复
    ///   - callback: 回调方法
    /// - Returns: Timer
    public static func scheduledTimer(timeInterval: TimeInterval, repeats: Bool, with callback: @escaping () -> Void) -> Timer {
        return scheduledTimer(timeInterval: timeInterval,
                              target: self,
                              selector: #selector(callbackInvoke(_:)),
                              userInfo: callback,
                              repeats: repeats)
    }

    /// 私有的定时器实现方法
    ///
    /// - Parameter timer: 定时器
    @objc
    private static func callbackInvoke(_ timer: Timer) {
        guard let callback = timer.userInfo as? () -> Void else { return }
        callback()
    }
}
