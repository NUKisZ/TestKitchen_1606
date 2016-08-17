//
//  UIImageView+Util.swift
//  TestKitchen
//
//  Created by NUK on 16/8/17.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

extension UIImageView{
    class func createImageView(imageName:String?)->UIImageView{
        let imageView = UIImageView()
        if let name = imageName{
            imageView.image = UIImage(named: name)
        }
        return imageView
    }
}

