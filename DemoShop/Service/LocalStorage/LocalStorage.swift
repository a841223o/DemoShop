//
//  LocalStorage.swift
//  DemoShop
//
//  Created by leo on 2022/5/22.
//

import Foundation


class LocalStorage {
    
    static let shared = LocalStorage()
    var orders = [Order]()
    
    
    func saveOrders( orders : [Order] ){
        self.orders = orders
    }
    func addOrders( order : Order ){
        self.orders.append(order)
    }
    func readOrders()->[Order]{
        return orders
    }
    
    
    
}
