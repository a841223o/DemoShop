//
//  ItemResponseModel.swift
//  DemoShop
//
//  Created by leo on 2022/5/21.
//

import Foundation


struct ItemResponseModel  : Codable {
    
    let id : Int
    let title : String
    let description : String
    let price : Double
    let category : String
    let image  : String
    
}
