//
//  ItemDetailViewController.swift
//  DemoShop
//
//  Created by leo on 2022/5/17.
//

import Foundation
import UIKit



class ItemDetailViewController : UIViewController  , ObserverProtocol {
    
    var observerId: Int = 1
    
    func onValueChanged(_ value: Any?) {
        guard let value = value as? Int else {
            return
        }
        cartBtn.setBadge(count: value)
    }
    
    
    let scrollerView = UIScrollView()
    let imageView = UIImageView()
    let nameLabel = UILabel()
    let descriptionLabel = UITextView()
    let priceLabel = UILabel()
    let bottomView = UIView()
    let addToCartBtn = UIButton()
    let goToPayBtn = UIButton()
    let stackView = UIStackView()
    let nameSpace = UIView()
    let cartBtn = BadgeButton()
    var item : Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ShoppingCart.shared.numberOfItems.addObserver(self)
        setupAutoLayout()
        setupScrollerView()
        setupBottomView()
        setupChartBtn()
        setup()
        
    }
 
    func setup(){
        UIImage.load(url: URL.init(string: item.image)!, completion: { image, url in
            self.imageView.image =  image
        })
        nameLabel.text = item.name
        descriptionLabel.text =  item.description
        priceLabel.text = "    " + "NT$ \(item.price)"
        priceLabel.textColor = .systemRed
        priceLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        nameLabel.font = UIFont.mediumFont
        descriptionLabel.sizeToFit()
        descriptionLabel.frame.size = CGSize.init(width: self.view.frame.width, height: descriptionLabel.frame.size.height)
        fitScrollerContentSize()
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
        scrollerView.addSubview(nameSpace)
        scrollerView.addSubview(nameLabel)
        scrollerView.addSubview(descriptionLabel)
        scrollerView.addSubview(priceLabel)
        imageView.frame.size = CGSize.init(width: scrollerView.frame.width, height: scrollerView.frame.width*1)
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        
        nameLabel.frame.size = CGSize.init(width: scrollerView.frame.width, height: 80)
        nameLabel.frame.origin = CGPoint.init(x: 16, y: imageView.frame.height)
        nameLabel.backgroundColor = .white
        nameLabel.numberOfLines = 2
        nameLabel.text =  "    neme"
        nameLabel.layoutIfNeeded()
        nameSpace.frame.origin = CGPoint.init(x: 0, y: imageView.frame.height)
        nameSpace.frame.size = nameLabel.frame.size
        nameSpace.backgroundColor = .white
        print(nameLabel.frame.size)
        print(nameLabel.frame.origin)
       
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
        fitScrollerContentSize()
    }
    func setupChartBtn(){
        let right = UIBarButtonItem.init(customView: cartBtn)
        self.navigationItem.rightBarButtonItem = right
        cartBtn.setImage(UIImage.init(systemName: "cart"), for: .normal)
        cartBtn.addTarget(self, action: #selector(presentToChartList), for: .touchUpInside)
        cartBtn.setBadge(count: ShoppingCart.shared.getItems().count)
        cartBtn.setTitle("  ", for: .normal)
    }
    
    func fitScrollerContentSize(){
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
        goToPayBtn.addTarget(self, action: #selector(buyRightNow), for: .touchUpInside)
        
        addToCartBtn.setTitle("加入購物車", for: .normal)
        addToCartBtn.setTitleColor(.red, for: .normal)
        addToCartBtn.setTitleColor(.systemRed, for: .highlighted)
        addToCartBtn.configuration = .plain()
        addToCartBtn.configuration?.background.strokeWidth = 2
        addToCartBtn.configuration?.background.strokeColor = .red
        addToCartBtn.addTarget(self, action: #selector(addItemToChartList), for: .touchUpInside)

    }
    
    @objc func presentToChartList(){
        let viewController = CartListViewController()
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc func addItemToChartList(){
        ShoppingCart.shared.add(item: item)
    }
    
    @objc func buyRightNow(){
        let order = Order.init(items: [item])
        let vc = order.type.createOrderViewController(order: order)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
