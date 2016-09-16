//
//  CommenCell.swift
//  LiangCangZangChunyu
//
//  Created by qianfeng on 16/9/10.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

import UIKit
import SnapKit

class CommenCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.creatUI()
    }
    lazy var iconImage:UIImageView = {
        let icomImage = UIImageView.init(frame: CGRectMake(10, 20, 50, 50))
        return icomImage
    }()
    lazy var nameLabel:UILabel = {
        let nl = UILabel.init(frame: CGRectMake(60, 20, 250, 20))
        nl.textColor = UIColor.init(red: 72/255.0, green: 187/255.0, blue: 246/255.0, alpha: 0.9)
        nl.font = UIFont.systemFontOfSize(16)
        return nl
    }()
    
    lazy var detailLabel:UILabel = {
        let dl = UILabel.init(frame: CGRectMake(60, 40, 250, 20))
        dl.numberOfLines = 0
        dl.userInteractionEnabled = true
        dl.textColor = UIColor.whiteColor()
        dl.font = UIFont.systemFontOfSize(16)
        return dl
    }()
    
    lazy var timeLabel:UILabel = {
        let tl = UILabel.init(frame: CGRectMake(60, 60, 250, 20))
        tl.textColor = UIColor.whiteColor()
        tl.font = UIFont.systemFontOfSize(14)
        return tl
    }()
    
    func creatUI() {
        
        self.contentView.addSubview(iconImage)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(detailLabel)
        self.contentView.addSubview(timeLabel)
        
        iconImage.snp_makeConstraints { (make) in
            make.top.equalTo(self.contentView).offset(20)
            make.leading.equalTo(self.contentView).offset(10)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        nameLabel.snp_makeConstraints { (make) in
            make.leading.equalTo(self.contentView).offset(70)
            make.top.equalTo(self.contentView).offset(20)
            make.trailing.equalTo(self.contentView).offset(-50)
            make.height.equalTo(20)
        }
        
        timeLabel.snp_makeConstraints { (make) in
            make.leading.equalTo(self.contentView).offset(70)
            make.trailing.equalTo(self.contentView).offset(-50)
            make.bottom.equalTo(self.contentView).offset(-10)
            make.height.equalTo(20)
        }
        
        detailLabel.snp_makeConstraints { (make) in
            make.leading.equalTo(self.contentView).offset(70)
            make.top.equalTo(self.nameLabel).offset(30)
            make.bottom.equalTo(self.timeLabel).offset(10)
            make.trailing.equalTo(self.contentView).offset(-50)
        }
        
        contentView.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.detailLabel.snp_bottom).offset(40)
            make.trailing.equalTo(self)
            make.top.equalTo(self)
            make.leading.equalTo(self)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
