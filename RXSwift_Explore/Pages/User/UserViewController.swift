//
//  UserView.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2025/2/27.
//  Copyright © 2025 mr dk. All rights reserved.
//

import Foundation
import UIKit

class UserViewController : UIViewController {
    
    let userService = UserService();
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        title = "User"
        
        userService.fetchUser(byID: 11) {  res in //Result<User, NetworkError>
            
            switch (res){
            case .success( let user):
                
                print("user === \(user.name)");
                break
            case .failure(let error):
                print("error == \(error.localizedDescription)");

            }
            
            
//            print("\(res.)")
        }
        
    }
    
}
