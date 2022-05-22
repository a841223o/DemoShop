//
//  Order.swift
//  DemoShop
//
//  Created by leo on 2022/5/19.
//

import Foundation

enum OrderType {
    case check
    case finished
    
    func createOrderViewBuilder(viewController : OrderViewController)->OrderViewBuilder {
        switch self {
        case .check:
            return CheckOrderViewBuilder(viewController: viewController)
        case .finished:
            return FinishOrderViewBuilder(viewController: viewController)
        }
    }
    
    func createOrderViewController(order : Order)->OrderViewController{
        switch self {
        case .check:
            let vc = CheckOrderViewController()
            vc.order = order
            return vc
        case .finished:
            let vc = FinishedOrderViewController()
            vc.order = order
            return vc
        }
    }
    
}


class Order {
    var type : OrderType = .check
    let id : String
    let items : [Item]
    let createTime : Date = Date.now
    var calculatorMethods: [CalculatorMethod] = [NormalCalculatorMethod() , DiscountCalculatorMethod()]
    var priceList : [Int] {
        var priceList : [Int] = []
        calculatorMethods.forEach { method in
            priceList.append(method.calculator(items: items))
        }
        return priceList
    }
    var totalPrice : Int {
        return priceList.reduce(0) {
            $0 + $1
        }
    }
  
    init(items:[Item]){
        var random = ""
        for _ in 0..<4{
            random += String(Int.random(in: 0...9))
        }
        self.id = String(Int(createTime.timeIntervalSince1970)) + random
        self.items = items
      
    }
    
}


