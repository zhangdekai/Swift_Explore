//
//  MutileClassImpTest.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2021/3/6.
//  Copyright © 2021 mr dk. All rights reserved.
//

import UIKit

class MutileClassImpTest: NSObject {

    //MARK: - 多态实现
    func testABClient() {
        
        let client:Client = AClient()
        client.connectIm()
    
        let client1:Client = BClient()
        client1.connectIm()
    }

}

//使用协议来实现，需要探究 ？？？ 未完成
protocol IMClientProtocol: NSObjectProtocol {
    func connectIm()
    func joinRoom(room: String)
}

class Client: NSObject {
    func connectIm() {
        
    }
    
    func joinRoom(room: String) {
        
    }
    
    var name: String?
    
    override init() {
        super.init()
    }
}

class AClient: Client {
    override func connectIm() {
        print("AClient")
    }
    
    override func joinRoom(room: String) {
        print("AClient")

    }
    
    override init() {
        super.init()
        
    }
}

class BClient: Client {
    override func connectIm() {
        print("BClient")

    }
    
    override func joinRoom(room: String) {
        print("BClient")

    }
    
    override init() {
        super.init()
        
    }
    
}

