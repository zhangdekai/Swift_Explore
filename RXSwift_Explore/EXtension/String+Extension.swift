//
//  String+Extension.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2020/12/21.
//  Copyright © 2020 mr dk. All rights reserved.
//

import Foundation

extension String {
    
    /// add char at index
    mutating func addString(_ string: String, at index: Int) {
        guard count > index else {
            return
        }
        let ind = self.index(self.startIndex, offsetBy: index)
        insert(contentsOf: string, at: ind)
    }
}
