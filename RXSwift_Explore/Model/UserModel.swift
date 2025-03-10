//
//  User.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2025/2/24.
//  Copyright © 2025 mr dk. All rights reserved.
//

import Foundation

//struct BaseDataModel<T: Decodable>: Decodable {
//
//    let code: Int
//    let message: String
//    let status: String
//    let data: T?
//}


///  json 转模型
/// https://app.quicktype.io/
///
struct UserBase: Decodable {
    let code: Int
    let message: String
    let status: String
    let data: UserModel
}

struct UserModel: Decodable {
    let id: Int
    let name: String
    let email: String
}
