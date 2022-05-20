//
//  ProfileViewController.swift
//  DemoShop
//
//  Created by leo on 2022/5/16.
//

import Foundation
import UIKit


class ProfileViewController : UIViewController , UITableViewDelegate , UITableViewDataSource {
    
    let tableView : UITableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.selectionStyle = .none
        cell.textLabel?.text = "查看訂單"
        cell.imageView?.image = UIImage.init(systemName: "list.bullet.rectangle.portrait")
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.tintColor = .systemRed
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        setupNavigationBar()
        setupTableView()
    }
    func setupTableView(){
        self.view.addSubview(tableView)
        tableView.frame.size = self.view.frame.size
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    func setupNavigationBar(){
       
        let appearance = UINavigationBarAppearance.init()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationItem.title = "Profile"
        
    }
    
    
}
