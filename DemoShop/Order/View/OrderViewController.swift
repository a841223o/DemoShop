//
//  CheckOrderViewController.swift
//  DemoShop
//
//  Created by leo on 2022/5/19.
//  不同狀態的訂單

import Foundation
import UIKit
class OrderViewController : UIViewController , UITableViewDelegate , UITableViewDataSource {
    var order : Order!
    var orderViewBuilder : OrderViewBuilder!
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoLayout()
        orderViewBuilder = order.type.createOrderViewBuilder(viewController: self)
        orderViewBuilder.order = order
        
    }
    
    func setupAutoLayout(){
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderViewBuilder.numberOfRowsInSection(section: section)
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return orderViewBuilder.numberOfSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return orderViewBuilder.getCell(section: indexPath.section, row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return orderViewBuilder.getHightForRowAt(section: indexPath.section, row: indexPath.row)
    }
    
}

class CheckOrderViewController : OrderViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView(){
        tableView.backgroundColor =  .white
    }
    
    func presentFinished(){
        ShoppingCart.shared.clearItemInOrder(order: order)
        order.type = .finished
        LocalStorage.shared.addOrders(order: order)
        self.navigationController?.pushViewController(OrderFinishedViewController(), animated: true)
    }
    
}

class FinishedOrderViewController : OrderViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView(){
        tableView.backgroundColor =  .white
    }
    
    func presentFinished(){
        self.navigationController?.pushViewController(OrderFinishedViewController(), animated: true)
    }
    
}
