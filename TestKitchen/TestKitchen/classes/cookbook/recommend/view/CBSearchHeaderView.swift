//
//  CBSearchHeaderView.swift
//  TestKitchen
//
//  Created by NUK on 16/8/18.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class CBSearchHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //搜索框
//        let searchBar = UISearchBar(frame: CGRectMake(0,0,bounds.size.width ,bounds.size.height))
//        searchBar.placeholder = "输入菜名或食材搜索"
//        searchBar.alpha = 0.5
//        
//        addSubview(searchBar)
 
        //可以用TextField来代替
        let textField = UITextField(frame: CGRectMake(40,4,bounds.size.width - 40*2,bounds.size.height-4*2))
        textField.borderStyle = .RoundedRect
        textField.placeholder = "输入菜名或食材搜索"
        addSubview(textField)
        

        let imageView = UIImageView.createImageView("search1")
        imageView.frame = CGRectMake(0, 0, 24, 24)
        textField.leftView = imageView
        textField.leftViewMode = .Always
        backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
