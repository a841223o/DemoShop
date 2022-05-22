//
//  TotalOrderCell.swift
//  DemoShop
//
//  Created by leo on 2022/5/20.
//

import UIKit

class TotalOrderCell : UITableViewCell{
    
    let label : UILabel = {
       let view = UILabel()
        view.text = "結帳總金額"
        view.textColor = .black
        view.font = .mediumFont
        return view
    }()
    let totalLabel : UILabel = {
       let view = UILabel()
        view.text = "NT$"
        view.textColor = .systemRed
        view.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return view
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(model : Order){
        
        totalLabel.text = "NT$ \(model.totalPrice)"
    }
    
    func setupAutoLayout(){
        let stack = UIStackView.init(arrangedSubviews: [label , totalLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(stack)
        
        let views = ["stack" : stack ]
        let buttonHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(32)-[stack]-(32)-|", options: [], metrics: nil, views: views)
        let buttonVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(16)-[stack]-(16)-|", options: [], metrics: nil, views: views)
        
        self.contentView.addConstraints(buttonHConstraints)
        self.contentView.addConstraints(buttonVConstraints)
    }
    
}
