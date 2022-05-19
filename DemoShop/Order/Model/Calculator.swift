//
//  Calculator.swift
//  DemoShop
//
//  Created by leo on 2022/5/19.
//

import Foundation
protocol CalculatorMethod {
    func calculator(items:[Item])->Int
}

class NormalCalculatorMethod : CalculatorMethod {
       
    func calculator(items:[Item])->Int{
        var total = 0
        items.forEach { item in
            total += item.price
        }
        return total
    }
    
}

class TaxCalculatorMethod : CalculatorMethod {
    
    func calculator(items:[Item])->Int{
        let tax = 20
        return tax
    }
    
}

class ShippingFeeCalculatorMethod : CalculatorMethod {
    
    func calculator(items:[Item])->Int{
        let total = 180
        return total
    }
    
}

class DiscountCalculatorMethod : CalculatorMethod {

    func calculator(items:[Item])->Int{
        if NormalCalculatorMethod().calculator(items: items) > 1000 {
            return -80
        }else{
            return 0
        }
    }
    
}

