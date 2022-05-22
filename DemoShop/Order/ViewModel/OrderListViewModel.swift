//
//  OrderListViewModel.swift
//  DemoShop
//
//  Created by leo on 2022/5/20.
//

import Foundation

protocol ViewModelDelegate : class {
    func didLoadData()
}

class OrderListViewModel {
    var orders : [Order] = []
    weak var delegate : ViewModelDelegate?
    var currentTypePage : OrderType = .check
    func loadOrders(){
        orders = LocalStorage.shared.readOrders()
        delegate?.didLoadData()
    }
    
    func getOrdersWithType() -> [Order]{
        return orders.filter { order in
            order.type == currentTypePage
        }
    }
    
}
