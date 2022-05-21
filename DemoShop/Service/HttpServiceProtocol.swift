//
//  HttpServiceProtocol.swift
//  DemoShop
//
//  Created by leo on 2022/5/21.
//

import Foundation


protocol HTTPServiceProtocol {
    func fetchItems(limit : Int , category : String?, complection : @escaping (Result<[ItemResponseModel] ,ServiceError >) -> Void)
}
