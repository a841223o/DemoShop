//
//  SendOrderCell.swift
//  DemoShop
//
//  Created by leo on 2022/5/19.
//

import Foundation
import UIKit

protocol SendOrderCellDelegate {
    func cell(_ sendOrderCell:UITableViewCell , checkBtnClicked : UIButton )
}

class SendOrderCell : UITableViewCell{
    var delegate : SendOrderCellDelegate?
    let button : UIButton = {
       let view = UIButton()
        view.configuration = .filled()
        view.configuration?.background.backgroundColor = .systemRed
        view.setTitle("提交訂單", for: .normal)
        view.addTarget(self, action: #selector(sendOrder(sender:)), for: .touchUpInside)
        return view
    }()
    
    @objc func sendOrder(sender : UIButton){
        delegate?.cell(self, checkBtnClicked: sender)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style:style, reuseIdentifier: reuseIdentifier)
        setupAutoLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func setupAutoLayout(){
        self.contentView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        let views = ["button" : button ]
        let buttonHConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-(32)-[button]-(32)-|", options: [], metrics: nil, views: views)
        let buttonVConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-(16)-[button]-(16)-|", options: [], metrics: nil, views: views)
        
        self.contentView.addConstraints(buttonHConstraints)
        self.contentView.addConstraints(buttonVConstraints)
    }
    
}
