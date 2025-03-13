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
    
    
    let viewModel = UserViewModel()
    
    let nameLabel = UILabel()
    let emailLabel = UILabel()
    let userIdLabel = UILabel()
        
    override func viewDidLoad() {
        
        view.backgroundColor = .white
        title = "User"
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp_topMargin).offset(30)
            make.left.equalTo(15)

        }
        
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(12)
            make.left.equalTo(15)

        }
        
        view.addSubview(userIdLabel)
        userIdLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(12)
            make.left.equalTo(15)

        }
        
        
        setViewData()
        
    }
    
    func setViewData(){
        
        viewModel.getUser { user in
            if(user != nil){
                self.nameLabel.text = user?.name
                self.emailLabel.text = user?.email
                self.userIdLabel.text = user?.id.description
            }
        }
        
    }
    
}
