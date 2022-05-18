//
//  CheckItemCell.swift
//  DemoShop
//
//  Created by leo on 2022/5/18.
//

import Foundation
import UIKit


class CheckItemCell : UITableViewCell {
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let namePriceStackView : UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.distribution = .fillEqually
        view.alignment = .top
        return view
    }()
    
    let horizontalStackView : UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()
    
    let checkBtn : UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.setImage(UIImage.init(named: "UnCheckBox")?.withTintColor(.gray), for: .normal)
        view.setImage(UIImage.init(named: "CheckBox")?.withTintColor(.systemRed), for: .selected)
        view.addTarget(self, action: #selector(tickCheckBtn(_:)), for: .touchUpInside)
        view.imageView?.contentMode = .scaleAspectFit
        view.contentHorizontalAlignment = .fill
        view.contentVerticalAlignment = .fill
        
        return view
    }()
    
    let deleteBtn : UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 24).isActive = true
        view.heightAnchor.constraint(equalToConstant: 24).isActive = true
        view.setImage(UIImage.init(systemName: "multiply")?.withTintColor(.gray), for: .normal)
        view.imageView?.tintColor = .gray
        view.imageView?.contentMode = .scaleAspectFit
        view.contentHorizontalAlignment = .fill
        view.contentVerticalAlignment = .fill
        
        return view
    }()
    
    let space : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        return view
    }()
    
    let nameLabel : UILabel = {
        let view = UILabel()
        view.text = "商品名稱"
        view.numberOfLines = 2
        view.font = UIFont.mediumFont
        return view
    }()
    
    let priceLabel : UILabel = {
        let view = UILabel()
        view.text = "NT$ 123"
        view.textColor = .systemRed
        view.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return view
    }()
    
    let itemImageView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage.init(named: "placeholder")
        view.widthAnchor.constraint(equalToConstant: 80).isActive = true
        view.heightAnchor.constraint(equalToConstant: 80).isActive = true
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupLayout()
    }
    
    func setupLayout(){
        
        self.namePriceStackView.addArrangedSubview(nameLabel)
        self.namePriceStackView.addArrangedSubview(priceLabel)
        self.containerView.addSubview(horizontalStackView)
        self.containerView.addSubview(deleteBtn)
        self.contentView.addSubview(containerView)
        self.horizontalStackView.addArrangedSubview(checkBtn)
        self.horizontalStackView.addArrangedSubview(itemImageView)
        self.horizontalStackView.addArrangedSubview(namePriceStackView)
        self.horizontalStackView.addArrangedSubview(space)
        
        let views = ["containerView" : containerView , "horizontalStackView": horizontalStackView , "deleteBtn" : deleteBtn]
        
        let containerViewVConstraints =  NSLayoutConstraint.constraints(withVisualFormat: "V:|-[containerView]-|", options: [], metrics: nil, views: views)
        let containerViewHConstraints =  NSLayoutConstraint.constraints(withVisualFormat: "H:|-[containerView]-|", options: [], metrics: nil, views: views)
        let stackHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(0)-[horizontalStackView]-(0)-|", options: [], metrics: nil, views: views)
        let stackVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(0)-[horizontalStackView]-(0)-|", options: [], metrics: nil, views: views)
        
        self.contentView.addConstraints(containerViewHConstraints)
        self.contentView.addConstraints(containerViewVConstraints)
        self.containerView.addConstraints(stackHConstraints)
        self.containerView.addConstraints(stackVConstraints)
        deleteBtn.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        deleteBtn.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
    }
    
    @objc func tickCheckBtn(_ sender : UIButton){
        sender.isSelected = !sender.isSelected
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
