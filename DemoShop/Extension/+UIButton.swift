//
//  +UIButton.swift
//  DemoShop
//
//  Created by leo on 2022/5/22.
//

import Foundation
import UIKit

extension UIButton {
//    func setBadge(count : Int){
//        if count == 0 {
//            self.subviews.forEach { view in
//                view.removeFromSuperview()
//            }
//            return
//        }
//        let lblBadge = UILabel.init(frame: CGRect.init(x: 20, y: 0, width: 20, height: 20))
//        lblBadge.backgroundColor = .systemRed
//        lblBadge.clipsToBounds = true
//        lblBadge.layer.cornerRadius = 7
//        lblBadge.textColor = UIColor.white
//        lblBadge.font = UIFont.systemFont(ofSize: 12)
//        lblBadge.textAlignment = .center
//        lblBadge.text = "\(count)"
//        self.addSubview(lblBadge)
//
//    }
}


class BadgeButton : UIButton{
    let badge : UILabel = {
        let view = UILabel()
        view.backgroundColor = .systemRed
        view.clipsToBounds = true
        view.layer.cornerRadius = 7
        view.textColor = UIColor.white
        view.font = UIFont.systemFont(ofSize: 12)
        view.textAlignment = .center
        view.frame = CGRect.init(x: 20, y: 0, width: 20, height: 20)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(badge)
    }
    
    func setBadge(count : Int){
        if count == 0 {
            badge.isHidden = true
        }else{
            badge.text = "\(count)"
            badge.isHidden = false
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
