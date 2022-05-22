//
//  OrderFinishedViewController.swift
//  DemoShop
//
//  Created by leo on 2022/5/20.
//  下單成功頁面

import Foundation
import UIKit


class OrderFinishedViewController : UIViewController {
    
    let button : UIButton = {
        let view = UIButton()
        view.setTitle("繼續購物", for: .normal)
        view.configuration = .plain()
        view.setTitleColor(.red, for: .normal)
        view.setTitleColor(.systemRed, for: .highlighted)
        view.configuration = .plain()
        view.configuration?.background.strokeWidth = 2
        view.configuration?.background.strokeColor = .red
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.addTarget(self, action: #selector(goToShop), for: .touchUpInside)
        return view
    }()
    let ordersButton : UIButton = {
        let view = UIButton()
        view.setTitle("查看訂單", for: .normal)
        view.configuration = .plain()
        view.setTitleColor(.red, for: .normal)
        view.setTitleColor(.systemRed, for: .highlighted)
        view.configuration = .plain()
        view.configuration?.background.strokeWidth = 2
        view.configuration?.background.strokeColor = .red
        view.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.addTarget(self , action: #selector(goToOrder), for: .touchUpInside)
        return view
    }()
    let label : UILabel = {
        let view = UILabel()
        view.text = "🎉下單成功"
        view.font = UIFont.systemFont(ofSize: 38)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupAutoLayout()
        setupNavigationBar()
    }
    
    func setupAutoLayout(){
        let stack = UIStackView.init(arrangedSubviews: [label ,ordersButton ,button])
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .equalCentering
        self.view.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.heightAnchor.constraint(equalTo: self.view.heightAnchor , multiplier: 0.3).isActive = true
        stack.widthAnchor.constraint(equalTo: self.view.widthAnchor , multiplier: 1).isActive = true
        stack.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        stack.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    func setupNavigationBar(){
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @objc func goToShop(){
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func goToOrder(){
        guard let order = LocalStorage.shared.readOrders().last else {
            return
        }
        let rootvc = self.navigationController?.viewControllers.first as! UIViewController
        let vc = order.type.createOrderViewController(order: order)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.setViewControllers([rootvc , vc], animated: true)
        
    }
}
