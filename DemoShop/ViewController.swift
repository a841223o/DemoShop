//
//  ViewController.swift
//  DemoShop
//
//  Created by leo on 2022/5/16.
//

import UIKit

class ViewController: UIViewController {
    let itemsViewController = ItemsViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let home = HomeViewController()
        home.modalPresentationStyle = .fullScreen
        self.present(home, animated: true)
    }


}

