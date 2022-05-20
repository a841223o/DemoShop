//
//  CustomTabBar.swift
//  DemoShop
//
//  Created by leo on 2022/5/21.
//

import Foundation
import UIKit
class CustomTabBarCell : UICollectionViewCell {
    let label = UILabel()
    let line = UIView()
    var text : String! {
        didSet {
            label.text = text
        }
    }
    
    var selectedTextColor : UIColor = .black
    var selectedBottomLineColor : UIColor = .black
    var unSelectedTextColor : UIColor = .gray
    var unSelectedBottomLineColor : UIColor = .gray
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAutoLayout(){
        self.addSubview(label)
        self.addSubview(line)
        // label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.font = UIFont.boldSystemFont(ofSize: 18)
        //line
        line.translatesAutoresizingMaskIntoConstraints = false
        line.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        line.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        line.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: 2).isActive = true
    }
    
    func selected(selected: Bool){
        if selected {
            label.textColor = selectedTextColor
            line.backgroundColor = selectedBottomLineColor
        }else{
            label.textColor = unSelectedTextColor
            line.backgroundColor = unSelectedBottomLineColor
        }
    }
    
}

class CustomTabBar : UIView {
    weak var delegate : CustomTabBarDelegate?
    private let collectionView = UICollectionView.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    private var titles = [String]()
    private var selectedTextColor : UIColor = .black
    private var selectedBottomLineColor : UIColor = .black
    private var unSelectedTextColor : UIColor = .gray
    private var unSelectedBottomLineColor : UIColor = .gray

    private var currentPosition = 0
    
    func setSelectedTextColor(_ color:UIColor ){
        selectedTextColor = color
    }
    func setSelectedBottomLineColor(_ color:UIColor ){
        selectedBottomLineColor = color
    }
    func setUnSelectedTextColor(_ color:UIColor ){
        unSelectedTextColor = color
    }
    func setUnSelectedBottomListColor(_ color:UIColor ){
        unSelectedBottomLineColor = color
    }
    func setPosition(position : Int){
        currentPosition = position
        collectionView.reloadData()
        delegate?.customTabBar(didSelectIndex: position, title: titles[position])
    }
    
    func setupAutoLayout(){
        self.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAutoLayout()
        
        collectionView.register(CustomTabBarCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).scrollDirection = .horizontal
    }
    
    func setTitles(titles : [String]){
        self.titles = titles
        collectionView.reloadData()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

protocol CustomTabBarDelegate  : class {
    func customTabBar(didSelectIndex : Int , title :String)
}

extension CustomTabBar : UICollectionViewDelegate ,UICollectionViewDataSource{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomTabBarCell
        let selected = currentPosition == indexPath.row
        cell.selectedBottomLineColor = selectedBottomLineColor
        cell.selectedTextColor = selectedTextColor
        cell.unSelectedTextColor = unSelectedTextColor
        cell.unSelectedBottomLineColor = unSelectedBottomLineColor
        cell.selected(selected: selected)
        cell.text = titles[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setPosition(position: indexPath.row)
    }
        
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //MARK: add scrollView
    }
}

extension CustomTabBar : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width * 20 / 100, height: collectionView.frame.height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}
