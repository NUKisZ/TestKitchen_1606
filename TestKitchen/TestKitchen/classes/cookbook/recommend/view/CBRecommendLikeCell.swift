//
//  CBRecommendLikeCell.swift
//  TestKitchen
//
//  Created by NUK on 16/8/17.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class CBRecommendLikeCell: UITableViewCell {
    
    
    
    @IBAction func clickBtn(sender: UIButton) {
    }
    //显示数据
    var model:CBRecommendWidgetListModel?{
        didSet{
            //显示图片和文字数据
            showData()
        }
    }
    
    //显求数据
    func showData(){
        for var i in 0..<8{
            //i 
            if model?.widget_data!.count > i {
                let imageModel = model?.widget_data![i]
                if imageModel?.type == "image"{
                    //获取图片视图
                    let index = i / 2
                    let subView = contentView.viewWithTag(200 + index)
                    if subView?.isKindOfClass(UIImageView.self) == true{
                        let imageView = subView as! UIImageView
                        let url = NSURL(string: (imageModel?.content)!)
                        let image = UIImage(named: "sdefaultImage")
                        imageView.kf_setImageWithURL(url, placeholderImage: image, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                    }
                }
            }
            if model?.widget_data?.count > i + 1{
                let textModel = model?.widget_data![i+1]
                if textModel?.type == "text"{
                 
                    //tag : 300 301 302 303
                    let subView = contentView.viewWithTag(300+(i/2))
                    if subView?.isKindOfClass(UILabel.self) == true{
                        let label = subView as! UILabel
                        label.text = textModel?.content!
                    }
                }
            }
            
            //每次遍历两个
            i += 1
        }
    }
    
    //创建cell的方法
    class func createLikeCellFor(tabelView:UITableView,atIndexPath indexPath:NSIndexPath,withListModel listModel:CBRecommendWidgetListModel)->CBRecommendLikeCell{
        
            let cellId = "recommendLikeCellId"
            var cell = tabelView.dequeueReusableCellWithIdentifier(cellId)as? CBRecommendLikeCell
            if cell == nil {
                cell = NSBundle.mainBundle().loadNibNamed("CBRecommendLikeCell", owner: nil, options: nil).last as? CBRecommendLikeCell
            }
            
            cell?.model = listModel
            return cell!
       
        
    
        
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
