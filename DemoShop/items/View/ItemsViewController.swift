//
//  ItemsViewController.swift
//  DemoShop
//
//  Created by leo on 2022/5/16.
//

import Foundation
import UIKit



class ItemsViewController : UIViewController {
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        setupNavigationBar()
    }
    
    func setupNavigationBar(){
        navigationItem.title = "Leo Shop"
    }
}

