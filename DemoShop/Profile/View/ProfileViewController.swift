//
//  ProfileViewController.swift
//  DemoShop
//
//  Created by leo on 2022/5/16.
//

import Foundation
import UIKit


class ProfileViewController : UIViewController {
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        setupNavigationBar()
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
