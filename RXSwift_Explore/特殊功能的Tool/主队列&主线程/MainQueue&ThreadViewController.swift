//
//  MainQueue&ThreadViewController.swift
//  Swift5.1Test
//
//  Created by zhang dekai on 2019/12/10.
//  Copyright © 2019 zhang dekai. All rights reserved.
//

import UIKit
/*M
 结论（conclusion）： Main queue must execute on main Thread。Main queue contain several threads
 
 主队列特点：如果主队列发现当前主线程有任务在执行，那么主队列会暂停调用队列的任务，直到主线程空闲为止。不会开辟新线程。
 
  DispatchQueue.main： The dispatch queue associated with the main thread of the current process.
 
 The system automatically creates the main queue and associates it with your application’s main thread.(系统自动创建主队列，并关联到主线程)
 
 
 */

class MainQueue_ThreadViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //主队列获取
        DispatchQueue.main//The dispatch queue associated with the main thread of the current process.
        //全局队列
        DispatchQueue.global()//Returns the global system queue with the specified quality-of-service class.
        
    }
    
   
}
