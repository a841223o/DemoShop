//
//  MockService.swift
//  DemoShop
//
//  Created by leo on 2022/5/21.
//

import Foundation

enum ServiceError : Error {
    case UnKnownURL
    case JsonDecoderFaild
}

class MockService : ServiceProtocol {
    
    func fetchItems(limit: Int, category: String? , complection : @escaping (Result<[ItemResponseModel] ,ServiceError >) -> Void) {
        guard let url = Bundle.init(for: MockService.self).url(forResource: "itemsResponse", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
                  return complection(.failure(.UnKnownURL))
        }
     
        guard let response = try? JSONDecoder().decode([ItemResponseModel].self, from: data) else {
            return complection(.failure(.JsonDecoderFaild))
        }
        
        if category == nil {
            return complection(.success(response))
        }
        
        let categoryItems = response.filter { model in
            model.category == category
        }
        
        return complection(.success(categoryItems))
        
        
        
    }
    
}
