//
//  BrandViewCell.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/11.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class BrandViewCell: UITableViewCell {
    
    @IBOutlet weak var brandImageView: UIImageView!

    
    @IBOutlet weak var brandLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
