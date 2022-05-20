//
//  OrderInfoCell.swift
//  DemoShop
//
//  Created by leo on 2022/5/21.
//

import Foundation
import UIKit
class OrderInfoCell : UITableViewCell{
    
    let title :UILabel = {
       let view = UILabel()
        view.text = "訂單編號"
        return view
    }()
    let number :UILabel = {
       let view = UILabel()
       view.text = ""
        return view
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func setupAutoLayout(){
        let stack = UIStackView.init(arrangedSubviews: [title , number])
        stack.axis = .vertical
        stack.distribution = .fillEqually
        self.contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        let views = ["stack" : stack ]
        let stackHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(32)-[stack]-(32)-|", options: [], metrics: nil, views: views)
        let stackVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(16)-[stack]-(16)-|", options: [], metrics: nil, views: views)
        
        self.contentView.addConstraints(stackHConstraints)
        self.contentView.addConstraints(stackVConstraints)
    }
    
    func setup(model : Order){
        number.text = model.id
    }
}
