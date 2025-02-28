
//
//  NetworkConfig.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2025/2/23.
//  Copyright © 2025 mr dk. All rights reserved.
//

import Foundation
import Alamofire

// 网络错误处理类
class NetworkErrorHandler {
    
    static func handleAFError<T>(_ error: AFError, response: AFDataResponse<T>) -> NetworkError {
        switch error {
        case .invalidURL:
            return .invalidURL
        case .responseSerializationFailed:
            return .decodingError
        case .sessionTaskFailed(let sessionError):
            if let urlError = sessionError as? URLError {
                switch urlError.code {
                case .timedOut:
                    return .requestTimedOut
                case .notConnectedToInternet:
                    return .noInternetConnection
                default:
                    return .requestFailed(response.response?.statusCode)
                }
            }
            return .requestFailed(response.response?.statusCode)
        case .responseValidationFailed(let reason):
            switch reason {
            case .unacceptableStatusCode(let code):
                if code == 401 {
                    return .unauthorized
                } else if (500...599).contains(code) {
                    return .serverError(code)
                }
                return .requestFailed(code)
            default:
                return .requestFailed(response.response?.statusCode)
            }
        default:
            return .requestFailed(response.response?.statusCode)
        }
    }
    static func handleDownloadError(_ error: AFError) -> NetworkError {
        return .downloadFailed
    }
    
    static func handleUploadError(_ error: AFError) -> NetworkError {
        return .uploadFailed
    }
}

