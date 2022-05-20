//
//  OrderViewBuilder.swift
//  DemoShop
//
//  Created by leo on 2022/5/19.
//

import Foundation
import UIKit

enum CellViewType : String {
    case item = "item"
    case checkBtn = "checkBtn"
    case totalOrder = "totalOrder"
}

protocol OrderViewBuilder {
    var order : Order {get set}
    var tableView : UITableView {get}
    var numberOfSection : Int { get }
    var sections : [CellViewType]  { get set }
    func numberOfRowsInSection(section : Int)->Int
    func getHightForRowAt(section : Int , row : Int)->Double
    func getCell(section : Int , row : Int)->UITableViewCell
}

class CheckOrderViewBuilder : OrderViewBuilder  , SendOrderCellDelegate {
  
    
    let viewController : CheckOrderViewController
    var order: Order
    
    func getHightForRowAt(section: Int, row: Int) -> Double {
        switch sections[section] {
        case .checkBtn:
            return 80
        case .item:
            return 160
        case .totalOrder:
            return 80
        }
    }
    
    func numberOfRowsInSection(section: Int)->Int {
        switch sections[section] {
        case .checkBtn:
            return 1
        case .item:
            return order.items.count
        case .totalOrder:
            return 1
        }
    }
    
    let tableView: UITableView
    
    var numberOfSection: Int {
        return sections.count
    }
    
    var sections: [CellViewType] = [.item ,.totalOrder, .checkBtn  ]
    
    func getCell(section : Int , row : Int) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: sections[section].rawValue, for: IndexPath.init(row: row, section: section))
        if let cell = cell as? ItemListCell {
           cell.setup(model: order.items[row])
        }
        
        if let cell = cell as? TotalOrderCell {
           cell.setup(model: order)
        }
        
        if let cell = cell as? SendOrderCell {
            cell.delegate = self
        }
        
        return cell 
        
    }
    
    init(viewController : OrderViewController ){
        self.viewController = viewController as! CheckOrderViewController
        self.order = viewController.order
        self.tableView = viewController.tableView
        self.tableView.register(ItemListCell.self, forCellReuseIdentifier: CellViewType.item.rawValue)
        self.tableView.register(SendOrderCell.self, forCellReuseIdentifier: CellViewType.checkBtn.rawValue)
        self.tableView.register(TotalOrderCell.self, forCellReuseIdentifier: CellViewType.totalOrder.rawValue)
    }
    
    func cell(_ sendOrderCell: UITableViewCell, checkBtnClicked: UIButton) {
        self.viewController.presentFinished()
    }
    
}


class FinishOrderViewBuilder : OrderViewBuilder  {
  
    
    let viewController : FinishedOrderViewController
    var order: Order
    
    func getHightForRowAt(section: Int, row: Int) -> Double {
        switch sections[section] {
        case .checkBtn:
            return 80
        case .item:
            return 160
        case .totalOrder:
            return 80
        }
    }
    
    func numberOfRowsInSection(section: Int)->Int {
        switch sections[section] {
        case .checkBtn:
            return 0
        case .item:
            return order.items.count
        case .totalOrder:
            return 1
        }
    }
    
    let tableView: UITableView
    
    var numberOfSection: Int {
        return sections.count
    }
    
    var sections: [CellViewType] = [.item ,.totalOrder, .checkBtn  ]
    
    func getCell(section : Int , row : Int) -> UITableViewCell {
        
        let cell =  tableView.dequeueReusableCell(withIdentifier: sections[section].rawValue, for: IndexPath.init(row: row, section: section))
        if let cell = cell as? ItemListCell {
           cell.setup(model: order.items[row])
        }
        
        if let cell = cell as? TotalOrderCell {
           cell.setup(model: order)
        }
        
        return cell
        
    }
    
    init(viewController : OrderViewController ){
        self.viewController = viewController as! FinishedOrderViewController
        self.order = viewController.order
        self.tableView = viewController.tableView
        self.tableView.register(ItemListCell.self, forCellReuseIdentifier: CellViewType.item.rawValue)
        self.tableView.register(SendOrderCell.self, forCellReuseIdentifier: CellViewType.checkBtn.rawValue)
        self.tableView.register(TotalOrderCell.self, forCellReuseIdentifier: CellViewType.totalOrder.rawValue)
    }
    
    func cell(_ sendOrderCell: UITableViewCell, checkBtnClicked: UIButton) {
        self.viewController.presentFinished()
    }
    
    
}
