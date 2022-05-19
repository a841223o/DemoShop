//
//  ItemDetailViewController.swift
//  DemoShop
//
//  Created by leo on 2022/5/17.
//

import Foundation
import UIKit



class ItemDetailViewController : UIViewController {
    
    let scrollerView = UIScrollView()
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let descriptionLabel = UITextView()
    let priceLabel = UILabel()
    let bottomView = UIView()
    let addToCartBtn = UIButton()
    let goToPayBtn = UIButton()
    let stackView = UIStackView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAutoLayout()
        setupScrollerView()
        setupBottomView()
    }
    
    func setupAutoLayout(){
        self.view.addSubview(scrollerView)
        self.view.addSubview(bottomView)
        scrollerView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        let views = ["scrollerView" : scrollerView , "bottomView" : bottomView ]
        let scrollerBottomConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-[scrollerView]-(0)-[bottomView(80)]-|", options: [], metrics: nil, views: views)
        let scrollerViewLeftRightConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[scrollerView]-(0)-|", options: [], metrics: nil, views: views)
        let bottomViewLeftRightConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[bottomView]-(0)-|", options: [], metrics: nil, views: views)
        self.view.addConstraints(scrollerBottomConstraints)
        self.view.addConstraints(scrollerViewLeftRightConstraints)
        self.view.addConstraints(bottomViewLeftRightConstraints)
    }
    
    func setupScrollerView(){
        scrollerView.backgroundColor = .systemGray4
        scrollerView.translatesAutoresizingMaskIntoConstraints = false
        scrollerView.layoutIfNeeded()
        scrollerView.addSubview(imageView)
        scrollerView.addSubview(nameLabel)
        scrollerView.addSubview(descriptionLabel)
        scrollerView.addSubview(priceLabel)
        imageView.frame.size = CGSize.init(width: scrollerView.frame.width, height: scrollerView.frame.width*1)
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        
        nameLabel.frame.size = CGSize.init(width: scrollerView.frame.width, height: 80)
        nameLabel.frame.origin = CGPoint.init(x: 0, y: imageView.frame.height)
        nameLabel.backgroundColor = .white
        nameLabel.text =  "    neme"
        
        priceLabel.frame.size = CGSize.init(width: scrollerView.frame.width, height: 80)
        priceLabel.frame.origin = CGPoint.init(x: 0, y: nameLabel.frame.origin.y + nameLabel.frame.height )
        priceLabel.backgroundColor = .white
        priceLabel.text =  "    NT 1,222"
        
        descriptionLabel.frame.size = CGSize.init(width: scrollerView.frame.width, height: scrollerView.frame.height/2)
        descriptionLabel.frame.origin = CGPoint.init(x: 0, y: priceLabel.frame.origin.y + priceLabel.frame.height + 8 )
        descriptionLabel.backgroundColor = .white
        descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        descriptionLabel.textContainerInset = UIEdgeInsets.init(top: 16, left: 16, bottom: 16, right: 16)
        descriptionLabel.isScrollEnabled = false
       
        descriptionLabel.text =  "Whether lineBreakMode is respected depends on how it's set. NSLineBreakByTruncatingTail (the default) is ignored after sizeToFit, as are the other two truncation modes (head and middle). NSLineBreakByClipping is also ignored. NSLineBreakByCharWrapping works as usual. The frame width is still narrowed to fit to the rightmost letter."
        let viewsInScrollView : [UIView] = [imageView,nameLabel,priceLabel,descriptionLabel]
        var scrollerContentHeight :CGFloat = 0.0
        viewsInScrollView.forEach { view in
            scrollerContentHeight += view.frame.height
        }
        
        scrollerView.contentSize = CGSize.init(width: scrollerView.frame.width ,height: scrollerContentHeight )
    }
    
    func setupBottomView(){
        stackView.addArrangedSubview(addToCartBtn)
        stackView.addArrangedSubview(goToPayBtn)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 32
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets.init(top: 16, left: 16, bottom: 16, right: 16)
        self.bottomView.addSubview(stackView)
        self.bottomView.backgroundColor = .red
        bottomView.layoutIfNeeded()
        stackView.frame.size = self.bottomView.frame.size
        stackView.backgroundColor  = .white
    
        goToPayBtn.setTitle("立刻購買", for: .normal)
        goToPayBtn.configuration = .filled()
        goToPayBtn.configuration?.background.backgroundColor = .systemRed
        goToPayBtn.addTarget(self, action: #selector(presentToChartList), for: .touchUpInside)
        
        addToCartBtn.setTitle("加入購物車", for: .normal)
        addToCartBtn.setTitleColor(.red, for: .normal)
        addToCartBtn.setTitleColor(.systemRed, for: .highlighted)
        addToCartBtn.configuration = .plain()
        addToCartBtn.configuration?.background.strokeWidth = 2
        addToCartBtn.configuration?.background.strokeColor = .red

    }
    
    @objc func presentToChartList(){
        let viewController = CartListViewController()
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
