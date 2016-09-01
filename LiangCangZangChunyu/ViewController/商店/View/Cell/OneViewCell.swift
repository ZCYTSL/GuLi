//
//  OneViewCell.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/11.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class OneViewCell: UITableViewCell {
    
    @IBOutlet weak var oneImage: UIImageView!
    @IBOutlet weak var twoImage: UIImageView!
    @IBOutlet weak var threeImage: UIImageView!
    @IBOutlet weak var fourImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
