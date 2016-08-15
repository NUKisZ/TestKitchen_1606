//
//  UIButton+Util.swift
//  TestKitchen
//
//  Created by NUK on 16/8/15.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

extension UIButton{
    class func createBtn(title:String?,bgImageName:String?,selectBgImageName:String?,target:AnyObject?,action:Selector?)->UIButton{
        let btn = UIButton(type: .Custom)
        if let btnTitle = title{
            btn.setTitle(btnTitle, forState: .Normal)
            btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        }
        if let btnBgImageName = bgImageName{
            btn.setBackgroundImage(UIImage(named: btnBgImageName), forState: .Normal)
        }
        if let btnSelectBgImageName = selectBgImageName{
            btn.setBackgroundImage(UIImage(named: btnSelectBgImageName), forState: .Selected)
        }
        if let btnTarget = target {
            if let btnAction = action{
                btn.addTarget(btnTarget, action: btnAction, forControlEvents: .TouchUpInside)
            }
            
        }
        
        
        
        return btn
    }
}
