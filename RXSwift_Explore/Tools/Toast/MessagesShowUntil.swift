//
//  MessagesShowUntil.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2025/3/10.
//  Copyright © 2025 mr dk. All rights reserved.
//

import Foundation
import SwiftMessages /// https://github.com/SwiftKickMobile/SwiftMessages


@MainActor
class MessagesShowUntil {
    

    public static func show(_ message: String){
        
        SwiftMessages.show(config: initConfig()) {
            
            let view = MessageView.viewFromNib(layout: .statusLine)
            view.configureTheme(.info)
                        
            view.configureContent(body: message)
            
            view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
            
            
            (view.backgroundView as? CornerRoundingView)?.cornerRadius = 12
            
            return view
            
        }
        
        func initConfig() -> SwiftMessages.Config {
            
            var config = SwiftMessages.Config()
            
            config.presentationStyle = .bottom
            
            config.prefersStatusBarHidden = true
            
            //        config.duration = .seconds(seconds: 2)
            config.duration = .automatic
            
//            config.dimMode = .gray(interactive: true)
            config.dimMode = .color(color: .clear, interactive: true)
            
            
            //        config.interactiveHide = false
            
            //        config.haptic = .success
            //        config.preferredStatusBarStyle = .lightContent
            
            return config

        }
    }
}
