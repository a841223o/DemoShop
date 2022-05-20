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
        //MARK:  orderProvider.fetch()
        let order1 = Order.init(items: [Item.init(name: "123", description: "123", price: 100, createTime: Date.now, image: "")])
        let order2 = Order.init(items: [Item.init(name: "123", description: "123", price: 100, createTime: Date.now, image: "")])
        let order3 = Order.init(items: [Item.init(name: "123", description: "123", price: 100, createTime: Date.now, image: "")])
        let order4 = Order.init(items: [Item.init(name: "123", description: "123", price: 100, createTime: Date.now, image: "")])

        order1.type = .check
        order2.type = .finished
        order3.type = .finished
        order4.type = .finished
        orders = [order1 , order2 , order3 , order4]
     
        delegate?.didLoadData()
    }
    
    func getOrdersWithType() -> [Order]{
        return orders.filter { order in
            order.type == currentTypePage
        }
    }
    
}
