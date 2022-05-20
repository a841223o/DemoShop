//
//  HomeViewController.swift
//  DemoShop
//
//  Created by leo on 2022/5/16.
//

import Foundation
import UIKit



class HomeViewController : UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        let itemsNavigationVC = UINavigationController.init(rootViewController: ItemsViewController()) ;
        let profileNavigationVC = UINavigationController.init(rootViewController: ProfileViewController()) ;
        
        itemsNavigationVC.tabBarItem.title = "商店"
        itemsNavigationVC.tabBarItem.image = UIImage.init(systemName: "gift")
        itemsNavigationVC.tabBarItem.selectedImage = UIImage.init(systemName: "gift.fill")
        profileNavigationVC.tabBarItem.title = "個人"
        profileNavigationVC.tabBarItem.image = UIImage.init(systemName: "person")
        profileNavigationVC.tabBarItem.selectedImage = UIImage.init(systemName: "person.fill")
        
        self.setViewControllers([itemsNavigationVC,profileNavigationVC], animated: false)
        
    }
    
}
