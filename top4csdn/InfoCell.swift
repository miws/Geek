//
//  InfoCell.swift
//  top4csdn
//
//  Created by tech on 16/3/1.
//  Copyright © 2016年 www.miw.cn. All rights reserved.
//

import UIKit
import SDWebImage

class InfoCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var from: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var author: UILabel!
    
    func setData(info:Info){
        title.text = info.title
        from.text = info.from
        time.text = info.time
        author.text = info.author
        icon.sd_setImageWithURL(NSURL(string: info.icon)!)
        icon.layer.cornerRadius = icon.bounds.height / 2
        icon.layer.masksToBounds = true
    }
}
