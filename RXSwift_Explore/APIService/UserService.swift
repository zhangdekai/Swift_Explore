//
//  UserService.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2025/2/24.
//  Copyright © 2025 mr dk. All rights reserved.
//

import Foundation

class UserService {
    
    func fetchUser(byID id: Int, completion: @escaping (Result<User, NetworkError>) -> Void) {
//        let endpoint = "/users/\(id)"
        let endpoint = ""

        NetworkService.shared.get(endpoint: endpoint, completion: completion)
    }
    
    func createUser(user: User, completion: @escaping (Result<User, NetworkError>) -> Void) {
        let endpoint = "/users"
        do {
            let parameters = try JSONEncoder().encode(user)
            let json = try JSONSerialization.jsonObject(with: parameters, options: []) as? [String: Any]
            NetworkService.shared.post(endpoint: endpoint, parameters: json, completion: completion)
        } catch {
            completion(.failure(.decodingError))
        }
    }
}
