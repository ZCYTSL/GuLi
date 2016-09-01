//
//  BrandListCell.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/18.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class BrandListCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImge: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var brandLabel: UILabel!

    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
