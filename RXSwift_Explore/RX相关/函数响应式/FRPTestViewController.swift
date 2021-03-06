//
//  FRPTestViewController.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2020/7/14.
//  Copyright © 2020 mr dk. All rights reserved.
//

import UIKit

class FRPTestViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // 函数式 - 数学 y = f(x) -> x = f(x) -> y = f(f(x))
        // x 参数  2 = 1+1 = 0+2
        // f 函数
        // y 返回值
        let array = [1,2,3,4,5,6,7]
        // 首先获取 > 3的数字
        // 获取的数字之后 + 1
        // 所有数字中的偶数
        // 可读性 清晰度
        //        for num in array{
        //            if num > 3{
        //                let number = num + 1
        //                if (number % 2 == 0) {
        //                    print(number)
        //                }
        //            }
        //        }
        
        
        // 系统自带高阶函数 实现方式
        // swift 可选性 + 类 + 枚举 + 结构体 + 协议 + 泛型
        array.filter{$0 > 3}
            .filter{($0 + 1) % 2 != 0}
            .forEach{print($0)}
    }
    
    
    
}
