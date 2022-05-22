//
//  CartListViewModel.swift
//  DemoShop
//
//  Created by leo on 2022/5/22.
//

import Foundation
import UIKit


class ChartListViewModel {
    
    var delegate : ViewModelDelegate?
    var checkedItems = [Int]()
    
    
    func getAllItems() -> [Item] {
        return ShoppingCart.shared.getItems()
    }
    
    func addCheckItem(index : Int){
        checkedItems.append(index)
        print(checkedItems)
    }
    
    func removeCheckItem(index : Int){
        checkedItems.removeAll { src in
            src == index
        }
        print(checkedItems)
    }
    
    func createOrder()->Order{
        let items = checkedItems.map { index in
            ShoppingCart.shared.getItems()[index]
        }
        return Order.init(items: items)
    }
    
    func deleteShoppingItem(index : Int){
        //被勾選的 item 被移除時勾選也要一併移除
        
        checkedItems.removeAll { value in
            value == index
        }
        checkedItems = checkedItems.map { value in
            if value > index {
                return value-1
            }
            return value
        }
        ShoppingCart.shared.remove(index: index)
        print(checkedItems)
        
    }
    
    
}
