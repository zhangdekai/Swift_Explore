
//
//  NetworkConfig.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2025/2/23.
//  Copyright © 2025 mr dk. All rights reserved.
//

import Foundation

// 网络错误枚举
enum NetworkError: Error {
    case invalidURL
    case requestFailed(Int?)
    case decodingError
    case requestTimedOut
    case noInternetConnection
    case serverError(Int)
    case unauthorized
    case downloadFailed
    case uploadFailed
    case requestCancelled
}

// 缓存策略
enum CachePolicy {
    case none
    case onlyCache
    case cacheThenUpdate
    case networkThenCache
}
