//
//  GREStudyUnpayView.swift
//  gredu-ios
//
//  Created by zhang dekai on 2018/10/25.
//  Copyright © 2018 dengrui. All rights reserved.
//

import Foundation
import UIKit

/// 加载xib View。ps: let view:UIView = SomeView.loadNib()
protocol GRENibloadable {}

extension GRENibloadable where Self : UIView {
    
    static func loadNib(_ nibNmae :String? = nil) -> Self {
        
        let nib = nibNmae ?? "\(self)"
        
        return Bundle.main.loadNibNamed(nib, owner: nil, options: nil)?.first as! Self
    }
}


/// 加载storyBoard 里的VC ，UIViewController遵守此协议即可
/// ps: let vc = SomeVC.instanceController("storyboard")

protocol LoadStoryBoard {}

enum StoryBoardName: String {
    case main = "Main"
}

extension LoadStoryBoard where Self : UIViewController {
    
    static func instanceController(_ storyBoard:StoryBoardName) -> Self {
        
        
        let sb = UIStoryboard(name: storyBoard.rawValue, bundle: nil)
        
        let vc = sb.instantiateViewController(withIdentifier: "\(self)") as! Self
        
        return vc
    }
}
