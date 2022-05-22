//
//  ViewController.swift
//  DemoShop
//
//  Created by leo on 2022/5/16.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var startBtn: UIButton!
    let itemsViewController = ItemsViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @IBAction func btnAction(_ sender: UIButton) {
        let home = HomeViewController()
        home.modalPresentationStyle = .fullScreen
        self.present(home, animated: true)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
    }


}

