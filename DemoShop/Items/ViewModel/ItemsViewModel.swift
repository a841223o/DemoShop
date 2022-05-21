//
//  ItemsViewModel.swift
//  DemoShop
//
//  Created by leo on 2022/5/21.
//

import Foundation


class ItemsViewModel {
    
    var items = [Item]()
    weak var delegate : ViewModelDelegate?
    
    func loadItems(){
        MockService().fetchItems(limit: 10, category: nil) { result in
            switch result {
            case .success(let models):
                
                let newItems = models.map { model in
                    Item.init(data: model)
                }
                self.items.append(contentsOf: newItems)
                self.delegate?.didLoadData()
            case .failure(_):
                ()
            }
        }
    }
    
    
}
