//
//  UserViewModel.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2025/3/4.
//  Copyright © 2025 mr dk. All rights reserved.
//

import Foundation

class UserViewModel {
    
    let userService = UserService();
    
    func getUser(_ completionHandler:@escaping (UserModel?)-> Void) {
        
        userService.getUser(byID: 11) {  res in //Result<User, NetworkError>
            
            switch (res){
            case .success( let user):
                
//                print("user === \(user.data)");
                
                completionHandler(user)
                break
            case .failure(let error):
                print("fetchUser error == \(error.localizedDescription)");
                completionHandler(nil)
                break
                
            }
            
        }
    }
    
    
    
}
