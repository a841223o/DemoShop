//
//  ItemsViewController.swift
//  DemoShop
//
//  Created by leo on 2022/5/16.
//

import Foundation
import UIKit



class ItemsViewController : UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , ViewModelDelegate , CustomTabBarDelegate  {

    
    var collectionView : UICollectionView!
    let viewModel = ItemsViewModel()
    let customTabBar = CustomTabBar()
    override func viewDidLoad() {
        self.view.backgroundColor = .gray
        setupAutoLayout()
        setupCollectionView()
        setupCustomTabBar()
        setupNavigationBar()
        viewModel.delegate = self
        viewModel.loadItems()
        
    }
    
    func setupAutoLayout(){
        let layout = UICollectionViewFlowLayout()
        let columnCount : Double = 2
        let space  : Double = 4
        let width = (self.view.frame.width - space*3 )/columnCount
        layout.itemSize = CGSize(
            width: width ,
            height: self.view.frame.height/3.5)
        layout.sectionInset = UIEdgeInsets.init(top: 4, left: 4, bottom: 4, right: 4)
        layout.estimatedItemSize = .zero
        layout.minimumInteritemSpacing = 4
        layout.minimumLineSpacing = 4
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.collectionView = collectionView
        self.view.addSubview(collectionView)
        self.view.addSubview(customTabBar)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        let views = ["collectionView" : collectionView , "customTabBar" : customTabBar]
        let tableViewHeadViewV = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[customTabBar(50)]-(0)-[collectionView]-|", options: [], metrics: nil, views: views)
        let headViewH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[customTabBar]-0-|", options: [], metrics: nil, views: views)
        let tableViewH = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[collectionView]-0-|", options: [], metrics: nil, views: views)
        self.view.addConstraints(tableViewHeadViewV)
        self.view.addConstraints(headViewH)
        self.view.addConstraints(tableViewH)
    }
    
    func setupCustomTabBar(){
        customTabBar.setTitles(titles: ["women's clothing" , "electronics" ,"men's clothing"])
        customTabBar.setSelectedTextColor(.systemRed)
        customTabBar.setSelectedBottomLineColor(.systemRed)
        customTabBar.setUnSelectedTextColor(.black)
        customTabBar.setUnSelectedBottomListColor(.white)
        customTabBar.delegate = self
    }
    func setupNavigationBar(){

        let appearance = UINavigationBarAppearance.init()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance        
        navigationItem.title = "商店"
        
    }
    
    
    func setupCollectionView(){
        
        collectionView.backgroundColor = .systemGray4
        collectionView.register(
          ItemCell.self,
          forCellWithReuseIdentifier: "ItemCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }

    func didLoadData(){
        self.collectionView.reloadData()
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        cell.setup(model: viewModel.items[indexPath.row] )
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ItemDetailViewController()
        vc.item = viewModel.items[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
        if indexPath.row+2 >= viewModel.items.count {
            viewModel.loadItems()
            self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0);
        }
    }
    
    
    func customTabBar(didSelectIndex: Int, title: String) {
        viewModel.category = title 
        viewModel.items.removeAll()
        viewModel.loadItems()
    }
    

}

