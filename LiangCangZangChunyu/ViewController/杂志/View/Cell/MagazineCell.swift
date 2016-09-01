//
//  MagazineCell.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/8/13.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit

class MagazineCell: UITableViewCell {
    
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var littelLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
