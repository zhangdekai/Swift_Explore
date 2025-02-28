//
//  EnumTestViewController.swift
//  Swift5.1Test
//
//  Created by zhang dekai on 2019/11/22.
//  Copyright © 2019 zhang dekai. All rights reserved.
//

import UIKit

//swift enmu 高级应用：https://blog.csdn.net/itchosen/article/details/77749152#c2


//MARK: - CaseIterable:只适合无关联值的 Enum
enum SwiftEnumTest:CaseIterable {
    case q1
    case q2
    case q3
}

//MARK: - 带有关联值（associated value）的Enum
enum DateEnum {
    case digit(year:Int, month:Int, day:Int)
    case string(String)
//    case boolType(Bool)
//    case doubleType(Double)
}

//MARK: - 带有原始值，原始值不占用枚举的内存。
enum GradeEnum:String {
    //不赋值的话 自带原始值，默认是case
    case perfert = "A"
    case great = "B"
    case good = "C"
    case bad = "D"
}

//MARK: - 给枚举添加函数，可修改self的值
enum MoveMent:Int {
    
    case left = 0
    case right = 1
    case up = 2
    case down = 3
    
    mutating func next() {//可修改self的值
        switch self {
        case .left:
            self = .right
        case .right:
            self = .up
        case .up:
            self = .down
        case .down:
            self = .up
        }
    }
}

enum Characters {//角色
    enum weapon {
        case bow
        case sward
    }
    case thief
    case knight
}

struct CharterStruct {//
    enum CharacterType {//角色
        
        case thief
        case knight
    }
    enum weapon {
        case bow
        case sward
    }
    
    let type:CharacterType
    let weapon:weapon
}

enum Trade {
    
    case buy(stock:String, amount:Int)
    case sell(stock:String, amount:Int)
    
    var isSell:Bool {//MARK: - add 计算属性
        switch self {
        case .buy(let stock, let amount):
            print("buy \(stock) \(amount)")
            return false
        case .sell(let stock, let amount):
            print("buy \(stock) \(amount)")
            return true
        }
        
    }
    
    func tradeDemo() -> String {//MARK: add 函数
        switch self {
        case .buy(let stock, let amount):
            return "buy \(stock) \(amount)"
        case .sell(let stock, let amount):
            return "sell \(stock) \(amount)"
        }
    }
    
    static func tradeAmount(_ trade:Trade)->Int {//MARK: add 静态方法
        
        if case let Trade.buy(_, amount) = trade {
            return amount
        }
        
        if case let Trade.sell(_, amount) = trade {
            return amount
        }
        
        return 0
    }
}

protocol AccountCompatible {
    var remaingFunds:Int {get}
    mutating func addFund(amount:Int) throws
    mutating func removeFund(amount:Int) throws
    
    associatedtype accountType
}

extension Trade: CustomStringConvertible,AccountCompatible {
    typealias accountType = Int //遵守协议的 需要指定 associatedtype的具体类型
    
    var remaingFunds: Int {
        return 0
    }
    
    func addFund(amount: Int) throws {
        
    }
    
    func removeFund(amount: Int) throws {
        try self.addFund(amount: amount)
    }
    
    
    var description: String {//CustomStringConvertible协议
        switch self {
        case .buy(_, _):
            return "烦死了快年底了"
        case .sell(_ , _):
            return "坚持拉拉纳"
        }
        
    }
    mutating func move(dist:CGVector){}
    mutating func attack() {}
}

enum FileNode {
    case file(String)
    indirect case folder(String,FileNode)//递归的方式保存数据
}



class EnumTestViewController: UIViewController {
    
    typealias Config = (RAM: Int, CPU: String, GPU: String)
    
    private var enumT:SwiftEnumTest = .q1
    
    private var enumDate:DateEnum = .digit(year: 2019, month: 11, day: 12)
    
    private var grade:GradeEnum = .perfert
    
    private var enumTrade:Trade = .buy(stock: "斯柯达", amount: 3)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        testCaseIterable()
        
        testAssociatedValue()
        
        print(enumTrade.tradeDemo())
        
        print(Trade.tradeAmount(enumTrade))
        

    }
    
    
    private func testEnum1() {
        
    }
    
    private func trade(_ trade:Trade) {
        switch trade {
        case .buy(let stock, let amount):
            print(stock,"-",amount)
        case .sell(let stock, let amount):
            print(stock,"-",amount)
        }
    }
    
    
    
    private func testAssociatedValue() {
        
        let character = CharterStruct(type: CharterStruct.CharacterType.knight, weapon: CharterStruct.weapon.bow)
        
        print(character)
        
        var date:DateEnum!
            
        date = .digit(year: 2019, month: 11, day: 29)
        date = .string("2019-11-12")
        
        switch date {//类型强推& 常量 导致警告和 .digit不执行
        case .digit(let year, let month, let day):
            print(year,month,day)
            break
        case .string(let value):
            print(value)
            break
        case .none:
            break
        }
        
        
        switch grade {
        case .perfert:
            print(GradeEnum.perfert.rawValue)
        case .great:
            print(GradeEnum.great.rawValue)
        case .good:
            print(GradeEnum.good.rawValue)
        case .bad:
            print(GradeEnum.bad.rawValue)
        }
        
        let moveMent = MoveMent(rawValue: 1)//right
        
        print(moveMent ?? 12)
        
        let charters = Characters.knight
        let weapon = Characters.weapon.bow
        print(charters,weapon)
        
    }
    
    //MARK: - CaseIterable allCases map
    private func testCaseIterable() {
        
        let caseString = SwiftEnumTest.allCases.map({"\($0)"}).joined(separator: ",")
        
        print(caseString)// q1,q2,q3
        
        SwiftEnumTest.allCases.forEach { (el) in
            print(el)// q1 q2 q3
        }
        print(MemoryLayout.size(ofValue: enumDate))//25 实际用到的空间
        
        print(MemoryLayout.stride(ofValue: enumDate))//32 分配的空间
        
        print(MemoryLayout.alignment(ofValue: enumDate))//8 对齐参数
        
    }
}
