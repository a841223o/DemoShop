//
//  Item.swift
//  DemoShop
//
//  Created by leo on 2022/5/19.
//

import Foundation


class Item {
    let id : Int
    let name :String
    let description :String
    let price : Int
    let createTime : Date
    let image : String

    init(){
        id = 0
        name = ""
        description = ""
        price = 0
        createTime = Date.now
        image = "" 
    }
    
    init(name : String , description : String , price : Int , createTime : Date , image : String){
        id = 0
        self.name = name
        self.description = description
        self.price = price
        self.createTime = createTime
        self.image = image
    }
    
    init( data : ItemResponseModel ){
        self.id = data.id
        self.name = data.title
        self.image = data.image
        self.createTime = Date.now
        self.price = Int(data.price)
        self.description = data.description
    }
}
