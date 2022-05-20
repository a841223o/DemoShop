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
    func getOrdersWithType(_ type:OrderType){
        //MARK:  orderProvider.fetch()
        let order1 = Order.init(items: [Item.init(name: "123", description: "123", price: 100, createTime: Date.now, image: "")])
        let order2 = Order.init(items: [Item.init(name: "123", description: "123", price: 100, createTime: Date.now, image: "")])
        let order3 = Order.init(items: [Item.init(name: "123", description: "123", price: 100, createTime: Date.now, image: "")])
        orders = [order1 , order2 , order3]
        delegate?.didLoadData()
    }
    
}
