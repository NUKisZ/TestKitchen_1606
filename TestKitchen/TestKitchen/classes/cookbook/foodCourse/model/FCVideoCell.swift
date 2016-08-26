//
//  FCVideoCell.swift
//  TestKitchen
//
//  Created by NUK on 16/8/25.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class FCVideoCell: UITableViewCell {
    
    
    @IBOutlet weak var bgImageView: UIImageView!
    
    @IBAction func playVideo(sender: AnyObject) {
        videoClosure!((model?.course_video)!)
    }
    
    @IBOutlet weak var titleLabel: UILabel!

    //视频播放
    var videoClosure:(String->Void)?
    
    var model:FoodCourseSerialModel?{
        didSet{
            if model != nil {
                showData()
            }
            
        }
    }
    
    func showData(){
        
        
        let url = NSURL(string: (model?.course_image)!)
        bgImageView.kf_setImageWithURL(url, placeholderImage: dImage, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
        if let count = model?.video_watchcount{
            titleLabel.text = String(format: "%@人看过", count)
        }
        
        
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
