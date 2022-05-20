//
//  ItemsViewController.swift
//  DemoShop
//
//  Created by leo on 2022/5/16.
//

import Foundation
import UIKit



class ItemsViewController : UIViewController , UICollectionViewDelegate , UICollectionViewDataSource  {

    var collectionView : UICollectionView!
    
    
    override func viewDidLoad() {
        self.view.backgroundColor = .gray
        setupCollectionView()
        setupNavigationBar()
        
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
        collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.frame = self.view.frame
        collectionView.backgroundColor = .systemGray4
        
        collectionView.register(
          ItemCell.self,
          forCellWithReuseIdentifier: "ItemCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.view.addSubview(collectionView)
        
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCell", for: indexPath) as! ItemCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(ItemDetailViewController(), animated: true)
    }
    
}

