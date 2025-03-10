//
//  UserService.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2025/2/24.
//  Copyright © 2025 mr dk. All rights reserved.
//

import Foundation

class UserService {
    
    let endpoint = "user"
    
    func fetchUser(byID id: Int, completion: @escaping (Result<UserModel, NetworkError>) -> Void) {
        NetworkService.shared.get(endpoint: endpoint, completion: completion)
    }
    
//    func createUser(user: UserModel, completion: @escaping (Result<UserBase, NetworkError>) -> Void) {
//        do {
//            let parameters = try JSONEncoder().encode(user)
//            let json = try JSONSerialization.jsonObject(with: parameters, options: []) as? [String: Any]
//            NetworkService.shared.post(endpoint: endpoint, parameters: json, completion: completion)
//        } catch {
//            completion(.failure(.decodingError))
//        }
//    }
}
