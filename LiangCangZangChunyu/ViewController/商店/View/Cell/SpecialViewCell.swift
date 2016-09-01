//
//  SpecialViewCell.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/11.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class SpecialViewCell: UITableViewCell {
    
    @IBOutlet weak var backImage: UIImageView!
    
    @IBOutlet weak var ditailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
