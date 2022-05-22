//
//  OrderListViewController.swift
//  DemoShop
//
//  Created by leo on 2022/5/20.
//

import Foundation
import UIKit

class OrderListViewController : UIViewController , ViewModelDelegate , UITableViewDelegate , UITableViewDataSource {

    let headView = CustomTabBar()
    let tableView = UITableView()
    let viewModel = OrderListViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupAutoLayout()
        setupTableView()
        setupCustomTab()
        viewModel.loadOrders()
    }
    
    func setupAutoLayout(){
        self.view.addSubview(tableView)
        self.view.addSubview(headView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        headView.translatesAutoresizingMaskIntoConstraints = false
        let views = ["tableView" : tableView , "headView" : headView]
        let tableViewHeadViewV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[headView(50)]-(0)-[tableView]-|", options: [], metrics: nil, views: views)
        let headViewH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[headView]-0-|", options: [], metrics: nil, views: views)
        let tableViewH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: [], metrics: nil, views: views)
        self.view.addConstraints(tableViewHeadViewV)
        self.view.addConstraints(headViewH)
        self.view.addConstraints(tableViewH)
    }
    
    func setupTableView(){
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        headView.backgroundColor = .blue
    }
    
    func setupCustomTab(){
        headView.setSelectedTextColor(.systemRed)
        headView.setSelectedBottomLineColor(.systemRed)
        headView.setUnSelectedTextColor(.black)
        headView.setUnSelectedBottomListColor(.white)
        headView.setTitles(titles: ["未完成" ,"已完成"])
        headView.delegate = self
    }
    
    func didLoadData() {
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  viewModel.getOrdersWithType().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
        cell.textLabel?.text = "訂單編號 : \(viewModel.getOrdersWithType()[indexPath.row].id)"
        cell.detailTextLabel?.text = "購買商品 x \(viewModel.getOrdersWithType()[indexPath.row].items.count)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let order = viewModel.getOrdersWithType()[indexPath.row]
        let vc = order.type.createOrderViewController(order: order)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


extension OrderListViewController : CustomTabBarDelegate {
    func customTabBar(didSelectIndex: Int, title: String) {
        let types :  [OrderType] = [.check , .finished]
        
        viewModel.currentTypePage = types[didSelectIndex]
        tableView.reloadData()
        
    }
}
