//
//  KTCHomeViewController.swift
//  TestKitchen
//
//  Created by NUK on 16/8/26.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class KTCHomeViewController: BaseViewController {
    //这个类,用来封装tabbar的显示和隐藏的方法

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    //显示tabbar
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let appDele = UIApplication.sharedApplication().delegate as! AppDelegate
        let ctrl = appDele.window?.rootViewController
        if ctrl?.isKindOfClass(MainTabBarController.self) == true{
            let mainTabBarCtrl = ctrl as! MainTabBarController
            mainTabBarCtrl.showTabbar()
        }
    }
    //隐藏
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        let appDele = UIApplication.sharedApplication().delegate as! AppDelegate
        let ctrl = appDele.window?.rootViewController
        if ctrl?.isKindOfClass(MainTabBarController.self) == true{
            let mainTabBarCtrl = ctrl as! MainTabBarController
            mainTabBarCtrl.hideTabar()
        }
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let appDele = UIApplication.sharedApplication().delegate as! AppDelegate
        let ctrl = appDele.window?.rootViewController
        if ctrl?.isKindOfClass(MainTabBarController.self) == true{
            let mainTabBarCtrl = ctrl as! MainTabBarController
            mainTabBarCtrl.showTabbar()
        }
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
