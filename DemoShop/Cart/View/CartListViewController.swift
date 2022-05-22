//
//  CartListViewController.swift
//  DemoShop
//
//  Created by leo on 2022/5/18.
//

import Foundation
import UIKit

class CartListViewController : UIViewController  {

    let itemTableView = UITableView()
    let bottomView = UIView()
    let checkBtn = UIButton()
    let viewModel = ChartListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoLayout()
        setupCheckBtn()
        setupBottomView()
        setupItemTableView()
        self.view.backgroundColor = .white
    }
    
    func setupAutoLayout(){
        
        self.view.addSubview(itemTableView)
        self.view.addSubview(bottomView)
        self.bottomView.addSubview(checkBtn)
        itemTableView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        checkBtn.translatesAutoresizingMaskIntoConstraints = false
        
        itemTableView.backgroundColor = .red
        bottomView.backgroundColor = .blue
        checkBtn.backgroundColor = .yellow
        
        let views = ["itemTableView" : itemTableView , "bottomView" : bottomView  , "checkBtn" : checkBtn]
        let tableViewBottomConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[itemTableView]-(0)-[bottomView(80)]-|", options: [], metrics: nil, views: views)
        let itemTableViewLeftRightConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[itemTableView]-(0)-|", options: [], metrics: nil, views: views)
        let bottomViewLeftRightConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[bottomView]-(0)-|", options: [], metrics: nil, views: views)
        
        let checkBtnVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(16)-[checkBtn]-(16)-|", options: [], metrics: nil, views: views)
        let checkBtnHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(32)-[checkBtn]-(32)-|", options: [], metrics: nil, views: views)
        
        self.view.addConstraints(tableViewBottomConstraints)
        self.view.addConstraints(itemTableViewLeftRightConstraints)
        self.view.addConstraints(bottomViewLeftRightConstraints)
        self.bottomView.addConstraints(checkBtnHConstraints)
        self.bottomView.addConstraints(checkBtnVConstraints)
        
    }
    
    func setupCheckBtn(){
        checkBtn.setTitle("結算", for: .normal)
        checkBtn.configuration = .filled()
        checkBtn.configuration?.background.backgroundColor = .systemRed
        checkBtn.addTarget(self, action: #selector(presentToCheckOrder), for: .touchUpInside)
        
    }
    
    func setupBottomView(){
        bottomView.backgroundColor = .white
    }
    
    func setupItemTableView(){
        itemTableView.delegate = self
        itemTableView.dataSource = self
        itemTableView.backgroundColor = .systemGray4
        itemTableView.register(CheckItemCell.self, forCellReuseIdentifier: "CheckItemCell")
    }
    
    @objc func presentToCheckOrder(){
        
        guard viewModel.checkedItems.count > 0 else {
            return
        }
        let vc = CheckOrderViewController()
        vc.order = viewModel.createOrder()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
}


extension CartListViewController :  UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getAllItems().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CheckItemCell", for: indexPath) as! CheckItemCell
        cell.setup(item: viewModel.getAllItems()[indexPath.row])
        cell.checkBtn.isSelected = viewModel.checkedItems.contains(indexPath.row)
        cell.addCheckBtnClickAction { item, isCheck in
            if isCheck {
                self.viewModel.addCheckItem(index: indexPath.row)
            }else{
                self.viewModel.removeCheckItem(index: indexPath.row)
            }
        }
        cell.addDeleteBtnClickAction { item in
            self.viewModel.deleteShoppingItem(index: indexPath.row)
            self.itemTableView.deleteRows(at: [indexPath], with: .left)
            self.itemTableView.reloadData()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
