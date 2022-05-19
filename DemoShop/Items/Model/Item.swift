//
//  Item.swift
//  DemoShop
//
//  Created by leo on 2022/5/19.
//

import Foundation


class Item {
    let name :String
    let description :String
    let price : Int
    let createTime : Date
    let image : String
    init(){
        name = ""
        description = ""
        price = 0
        createTime = Date.now
        image = "" 
    }
    init(name : String , description : String , price : Int , createTime : Date , image : String){
        self.name = name
        self.description = description
        self.price = price
        self.createTime = createTime
        self.image = image
    }
}
