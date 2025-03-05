//
//  NetworkService.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2025/2/23.
//  Copyright © 2025 mr dk. All rights reserved.
//

import Foundation
import Alamofire

/// 生成路径 豆包
/// https://www.doubao.com/chat/collection/1537384313292034?type=Thread
///

// 网络服务类
class NetworkService {
    static let shared = NetworkService()
    private let session: Session
    private let memoryCache = MemoryCache.shared
    private var defaultHeaders: HTTPHeaders = [:]
    private var currentRequests: [Request] = []
    
    
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = NetworkConfig.timeoutInterval
        let cache = URLCache(memoryCapacity: 5 * 1024 * 1024, diskCapacity: 100 * 1024 * 1024, diskPath: "myAppCache")
        configuration.urlCache = cache
        session = Session(configuration: configuration)
    }
    
    // 构建完整的请求 URL
    private func buildURL(with endpoint: String) -> URL? {
        return URL(string: NetworkConfig.baseURL + endpoint)
    }
    
    // 生成缓存键
    private func generateCacheKey(endpoint: String, parameters: Parameters?) -> String {
        return "\(endpoint)_\(parameters?.description ?? "")"
    }
    
    // 记录请求日志
    private func logRequest(_ request: URLRequest) {
        print("Request: \(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
        if let headers = request.allHTTPHeaderFields {
            print("Headers: \(headers)")
        }
        if let body = request.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            print("Body: \(bodyString)")
        }
    }
    
    // 记录响应日志
    private func logResponse(_ response: AFDataResponse<Data>) {
        print("Response Status Code: \(response.response?.statusCode ?? -1)")
        if let data = response.data, let dataString = String(data: data, encoding: .utf8) {
            print("Response Data: \(dataString)")
        }
    }
    
    // 统一的请求方法
    private func performRequest<T: Decodable>(
        method: HTTPMethod,
        endpoint: String,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        cachePolicy: CachePolicy = .none,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        let cacheKey = generateCacheKey(endpoint: endpoint, parameters: parameters)
        
        switch cachePolicy {
        case .onlyCache:
            if let cachedData = memoryCache.object(forKey: cacheKey) as? Data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: cachedData)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingError))
                }
            } else {
                completion(.failure(.requestFailed(nil)))
            }
            break
        case .cacheThenUpdate:
            if let cachedData = memoryCache.object(forKey: cacheKey) as? Data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: cachedData)
                    completion(.success(result))
                } catch {
                    completion(.failure(.decodingError))
                }
            }
            // 发起网络请求更新缓存
            performNetworkRequest(method: method, endpoint: endpoint, parameters: parameters, encoding: encoding, headers: headers, cacheKey: cacheKey, completion: completion)
            break
        case .networkThenCache:
            performNetworkRequest(method: method, endpoint: endpoint, parameters: parameters, encoding: encoding, headers: headers, cacheKey: cacheKey, completion: completion)
            break
        case .none:
            // 不使用缓存，直接发起网络请求
            performNetworkRequest(method: method, endpoint: endpoint, parameters: parameters, encoding: encoding, headers: headers, cacheKey: nil, completion: completion)
            break
        }
    }
    
    // 执行网络请求
    private func performNetworkRequest<T: Decodable>(
        method: HTTPMethod,
        endpoint: String,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        cacheKey: String?,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let url = buildURL(with: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = NetworkConfig.timeoutInterval
        
        do {
            let encodedURLRequest = try encoding.encode(request, with: parameters)
            
            
            headers?.forEach({ header in
                request.setValue(header.name, forHTTPHeaderField: header.value)
            })
            
            defaultHeaders.forEach { head in
                request.setValue(head.name, forHTTPHeaderField: head.value)
            }
            
            logRequest(encodedURLRequest)
            
            let afRequest = session.request(encodedURLRequest)
                .validate()
                .responseData { [weak self] response in
                    
                    self?.logResponse(response)
                    
                    switch response.result {
                    case .success(let data):
                        print("data 111 === \(data)");
                        if let cacheKey = cacheKey {
                            self?.memoryCache.setObject(data as AnyObject, forKey: cacheKey)
                        }
                        
                        do {
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(T.self, from: data)
                            completion(.success(result))
                        } catch {
                            print("data decodingError === \(data)");
                            completion(.failure(.decodingError))
                        }
                    case .failure(let error):
                        print("responseData error.localizedDescription == \(error.localizedDescription)")
                        let networkError = NetworkErrorHandler.handleAFError(error, response: response)
                        completion(.failure(networkError))
                    }
                }
            currentRequests.append(afRequest)
        } catch {
            completion(.failure(.requestFailed(nil)))
        }
    }
    
    // GET 请求方法
    func get<T: Decodable>(
        endpoint: String,
        parameters: Parameters? = nil,
        headers: HTTPHeaders? = nil,
        cachePolicy: CachePolicy = .networkThenCache,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        performRequest(method: .get, endpoint: endpoint, parameters: parameters, headers: headers, cachePolicy: cachePolicy, completion: completion)
    }
    
    // POST 请求方法
    func post<T: Decodable>(
        endpoint: String,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        cachePolicy: CachePolicy = .networkThenCache,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        performRequest(method: .post, endpoint: endpoint, parameters: parameters, encoding: encoding, headers: headers, cachePolicy: cachePolicy, completion: completion)
    }
    
    // PUT 请求方法
    func put<T: Decodable>(
        endpoint: String,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        cachePolicy: CachePolicy = .networkThenCache,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        performRequest(method: .put, endpoint: endpoint, parameters: parameters, encoding: encoding, headers: headers, cachePolicy: cachePolicy, completion: completion)
    }
    
    // DELETE 请求方法
    func delete<T: Decodable>(
        endpoint: String,
        parameters: Parameters? = nil,
        encoding: ParameterEncoding = URLEncoding.default,
        headers: HTTPHeaders? = nil,
        cachePolicy: CachePolicy = .networkThenCache,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        performRequest(method: .delete, endpoint: endpoint, parameters: parameters, encoding: encoding, headers: headers, cachePolicy: cachePolicy, completion: completion)
    }
    
    // 下载文件
    func download(
        endpoint: String,
        headers: HTTPHeaders? = nil,
        to destination: DownloadRequest.Destination? = nil,
        progress: @escaping (Progress) -> Void,
        completion: @escaping (Result<URL, NetworkError>) -> Void
    ) {
        guard let url = buildURL(with: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var combinedHeaders = defaultHeaders
        headers?.forEach { combinedHeaders.add(name: $0.name, value: $0.value) }
        
        let destination: DownloadRequest.Destination = destination ?? { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("downloaded_file")
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        let down = session.download(url, method: .get, headers: combinedHeaders, to: destination)
            .downloadProgress{ progress($0)}
            .response { response in
                switch response.result {
                case .success(let fileURL):
                    if let url = fileURL {
                        completion(.success(url))
                    } else {
                        completion(.failure(.downloadFailed))
                    }
                case .failure(let error):
                    let networkError = NetworkErrorHandler.handleDownloadError(error)
                    completion(.failure(networkError))
                }
            }
        currentRequests.append(down)
    }
    
    // 上传文件
    func upload(
        fileURL: URL,
        endpoint: String,
        headers: HTTPHeaders? = nil,
        progress: @escaping (Progress) -> Void,
        completion: @escaping (Result<Data?, NetworkError>) -> Void
    ) {
        guard let url = buildURL(with: endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var combinedHeaders = defaultHeaders
        headers?.forEach { combinedHeaders.add(name: $0.name, value: $0.value) }
        
        let uploadRequest = session.upload(fileURL, to: url, method: .post, headers: combinedHeaders)
            .validate()
            .uploadProgress{ progress($0)}
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(.success(data))
                case .failure(let error):
                    let networkError = NetworkErrorHandler.handleUploadError(error)
                    completion(.failure(networkError))
                }
            }
        currentRequests.append(uploadRequest)
    }
    
    
    // 取消所有请求
    func cancelAllRequests() {
        currentRequests.forEach { $0.cancel() }
        currentRequests.removeAll()
    }
    
    // 清除所有缓存（内存和磁盘）
    func clearAllCaches() {
        // 清除内存缓存
        memoryCache.removeAllObjects()
        // 清除磁盘缓存
        session.session.configuration.urlCache?.removeAllCachedResponses()
    }
    
    // 清除指定请求的缓存
    func clearCache(forEndpoint endpoint: String, parameters: Parameters? = nil) {
        let cacheKey = generateCacheKey(endpoint: endpoint, parameters: parameters)
        // 清除内存缓存
        memoryCache.removeObject(forKey: cacheKey)
        // 尝试清除磁盘缓存中对应 URL 的缓存
        if let url = buildURL(with: endpoint) {
            var request = URLRequest(url: url)
            if let params = parameters {
                request.url = URL(string: "\(url.absoluteString)?\(params.description)")
            }
            session.session.configuration.urlCache?.removeCachedResponse(for: request)
        }
    }
    
    
    
    // 设置默认的 Content-Type 请求头
    func setContentType(_ contentType: String) {
        defaultHeaders.add(name: "Content-Type", value: contentType)
    }
    
    // 设置 Authorization 请求头
    func setAuthorization(_ token: String) {
        defaultHeaders.add(name: "Authorization", value: "Bearer \(token)")
    }
    
    // 设置 Accept 请求头
    func setAccept(_ accept: String) {
        defaultHeaders.add(name: "Accept", value: accept)
    }
    
    // 设置 Accept-Language 请求头
    func setAcceptLanguage(_ language: String) {
        defaultHeaders.add(name: "Accept-Language", value: language)
    }
}
