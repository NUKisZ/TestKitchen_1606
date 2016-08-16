//
//  BaseViewController.swift
//  TestKitchen
//
//  Created by NUK on 16/8/15.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func addNavTitle(title:String){
        let titleLabel = UILabel.createLabel(title, font: UIFont.systemFontOfSize(24), textAlignment: NSTextAlignment.Center, textColor: UIColor.blackColor())
        navigationItem.titleView = titleLabel
    }
    //导航按钮
    func addNavBtn(imageName:String,target:AnyObject?,action:Selector?,isLeft:Bool){
        let btn = UIButton.createBtn(nil, bgImageName: imageName, selectBgImageName: nil, target: target, action: action)
        let barBtnItem = UIBarButtonItem(customView: btn)
        if isLeft{
            navigationItem.leftBarButtonItem = barBtnItem
        }else{
            navigationItem.rightBarButtonItem = barBtnItem
        }
        
        
    }
    
    //返回按钮
    func addNavBackBtn(){
        addNavBtn("nav_back_black", target: self, action: #selector(backAction), isLeft: true)
        
    }
    func backAction(){
        navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
