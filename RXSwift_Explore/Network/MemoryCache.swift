//
//  MemoryCache.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2025/2/24.
//  Copyright © 2025 mr dk. All rights reserved.
//

import Foundation

// 内存缓存类
class MemoryCache {
    static let shared = MemoryCache()
    
    private let cache = NSCache<NSString, AnyObject>()

    func setObject(_ object: AnyObject, forKey key: String) {
        cache.setObject(object, forKey: key as NSString)
    }

    func object(forKey key: String) -> AnyObject? {
        return cache.object(forKey: key as NSString)
    }

    func removeObject(forKey key: String) {
        cache.removeObject(forKey: key as NSString)
    }

    func removeAllObjects() {
        cache.removeAllObjects()
    }
}
