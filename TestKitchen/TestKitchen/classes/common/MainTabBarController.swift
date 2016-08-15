//
//  MainTabBarController.swift
//  TestKitchen
//
//  Created by NUK on 16/8/15.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    //计算属性
    private var array:Array<Dictionary<String,String>>?{
        get{
            //读文件
            let path = NSBundle.mainBundle().pathForResource("Ctrl.json", ofType: nil)
            var myArray:Array<Dictionary<String,String>>? = nil
            if let filePath = path{
                let data = NSData(contentsOfFile: filePath)
                
                if let jsonData = data{
                    do {
                        let jsonVale = try NSJSONSerialization.JSONObjectWithData(jsonData, options: .MutableContainers)
                        if jsonVale.isKindOfClass(NSArray.self){
                            myArray = jsonVale as? Array<Dictionary<String,String>>
                        }
                    }
                    catch {
                        //程序出现异常
                       print(error)
                        return nil
                    }
                    
                }
                
            }
            return myArray
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //创建视图控制器
        
        createViewControllers()
        
        
        
    }
    
    //创建视图控制器
    func createViewControllers(){
//        let ctrlNames = ["CookBookViewController","CommunityViewController","MallViewController","FoodClassViewController","ProfileViewController"]
        var ctrlNames = [String]()
        if let tmeArray = self.array{
            //json解析成功
            //并且数组里面有数据
            for dict in tmeArray{
                let name = dict["ctrlName"]
                ctrlNames.append(name!)
            }
        }else{
            ctrlNames = ["CookBookViewController","CommunityViewController","MallViewController","FoodClassViewController","ProfileViewController"]
        }
        
        var vCtrlArray = Array<UINavigationController>()
        for i in 0..<ctrlNames.count{
            
            
            
            //创建视图控制器
            let ctrlName = "TestKitchen." + ctrlNames[i]
            let cls = NSClassFromString(ctrlName) as! UIViewController.Type
            let ctrl = cls.init()
            //导航视图
            let navCtrl = UINavigationController(rootViewController: ctrl)
            vCtrlArray.append(navCtrl)
        }
        self.viewControllers = vCtrlArray
        
        
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
