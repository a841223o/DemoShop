//
//  ItemCell.swift
//  DemoShop
//
//  Created by leo on 2022/5/17.
//

import Foundation
import UIKit

class ItemCell: UICollectionViewCell {
    var cardView : UIView!
    var imageView : UIImageView!
    var nameLabel : UILabel!
    var priceLabel : UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        cardView =  UIView()
        cardView.frame.size = CGSize.init(width:self.frame.width ,  height: self.frame.height)
        cardView.backgroundColor = .white
        self.addSubview(cardView)
        
        imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.frame.size = CGSize.init(width:self.frame.width ,  height: self.frame.height*2/3)
        cardView.addSubview(imageView)
        
        nameLabel = UILabel()
        nameLabel.numberOfLines = 2
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        nameLabel.frame.size = CGSize.init(width:self.frame.width-8 ,  height: self.frame.height/6)
        nameLabel.frame.origin = CGPoint.init(x: 8, y: self.frame.height*2/3)
        nameLabel.text = "title title title title title title title title title title title titletitle"
        cardView.addSubview(nameLabel)
        
        priceLabel = UILabel()
        priceLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        priceLabel.frame.size = CGSize.init(width:self.frame.width-8 ,  height: self.frame.height/6)
        priceLabel.frame.origin = CGPoint.init(x: 8, y: self.frame.height*2/3 + self.frame.height/6)
        priceLabel.text = "NT$ 1,888"
        cardView.addSubview(priceLabel)
        
        cardView.clipsToBounds = true
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var task : URLSessionDataTask?

    func setup(model : Item){

        nameLabel.text = model.name
        priceLabel.text = "NT$ \(model.price)"
        task = UIImage.load(url: URL.init(string: model.image)!) { image , url in
            DispatchQueue.main.async {
                    self.imageView.alpha = 1
                    self.imageView.image = image
            }
        }
    }
    
    override func prepareForReuse() {
        task?.cancel()
        task = nil
    }
}
