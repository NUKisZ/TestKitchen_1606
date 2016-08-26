//
//  FCCommentCell.swift
//  TestKitchen
//
//  Created by NUK on 16/8/26.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class FCCommentCell: UITableViewCell {
    
    
    @IBOutlet weak var userImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    

    @IBAction func reportAction(sender: AnyObject) {
    }
    
    var model:FCCommentDetail?{
        didSet{
            if model != nil{
                showData()
            }
            
        }
    }
    func showData(){
        //图片
        userImageView.layer.cornerRadius = 30
        userImageView.layer.masksToBounds = true
        let url = NSURL(string: (model?.head_img)!)
        userImageView.kf_setImageWithURL(url, placeholderImage: dImage, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        nameLabel.text = model?.nick
        contentLabel.text = model?.content
        timeLabel.text = model?.create_time
        
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
