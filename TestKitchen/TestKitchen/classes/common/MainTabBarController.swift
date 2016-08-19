//
//  MainTabBarController.swift
//  TestKitchen
//
//  Created by NUK on 16/8/15.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    //tabbar的背景视图
    private var bgView:UIView?
    
    
    
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
        var imageNames = [String]()
        var titleNames = [String]()
        if let tmeArray = self.array{
            //json解析成功
            //并且数组里面有数据
            for dict in tmeArray{
                let name = dict["ctrlName"]
                ctrlNames.append(name!)
                titleNames.append(dict["titleName"]!)
                imageNames.append(dict["imageName"]!)
            }
        }else{
            ctrlNames = ["CookBookViewController","CommunityViewController","MallViewController","FoodClassViewController","ProfileViewController"]
            
            //home_normal
            //home_select
            
            //community_normal
            //community_select
            
            //shop_normal
            //shop_select
            
            //shike_normal
            //shike_select
            
            //mine_normal
            //mine_select
            
            titleNames = ["食材","社区","商城","食课","我的"]
            imageNames = ["home","community","shop","shike","mine"]
            
            
            
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
        //自定制TabBar
        createCustomTabbar(titleNames, imageNames: imageNames)
        
    }
    
    //定制TabBar
    func createCustomTabbar(titleNames:[String],imageNames:[String]){
        //创建背景视图
        bgView = UIView.createView()
        //设置一个边框
        bgView?.backgroundColor = UIColor.whiteColor()
        bgView?.layer.borderWidth = 1
        bgView?.layer.borderColor = UIColor.grayColor().CGColor
        view.addSubview(self.bgView!)
        //添加约束
        bgView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.left.right.equalTo(self!.view)
            make.bottom.equalTo(self!.view)
            make.top.equalTo(self!.view.snp_bottom).offset(-49)
            
        })
        
        //2.循环添加按钮
        //按钮的宽度
        let width = kScreenWidth / 5.0
        for i in 0..<titleNames.count{
            //图片的名字
            let imageName = imageNames[i]
            let titleName = titleNames[i]
            //2.1按钮
            let btn = UIButton.createBtn(nil, bgImageName: imageName + "_normal", selectBgImageName: imageName + "_select", target: self, action: #selector(clickBtn(_:)))
            
            bgView?.addSubview(btn)
            //约束
            btn.snp_makeConstraints(closure: {
                [weak self]
                (make) in
                make.top.bottom.equalTo(self!.bgView!)
                make.width.equalTo(width)
                make.left.equalTo(width * CGFloat(i))
            })
            
            //2.2文字
            let label = UILabel.createLabel(titleName, font: UIFont.systemFontOfSize(8), textAlignment: NSTextAlignment.Center, textColor: UIColor.grayColor())
            btn.addSubview(label)
            //约束
            label.snp_makeConstraints(closure: {
                (make) in
                make.left.right.equalTo(btn)
                make.top.equalTo(btn).offset(32)
                make.height.equalTo(12)
            })
            btn.tag = 3000 + i
            label.tag = 4000
            //默认选中第一个按钮
            if i == 0 {
                btn.selected = true
                label.textColor = UIColor.orangeColor()
            }
        }
        
        
        
        
    }
    
    func clickBtn(curBtn:UIButton){
        //1.取消之前选中按钮的状态
        let lastBtnView = bgView?.viewWithTag(3000 + selectedIndex)
        if let tmpBtn = lastBtnView{
            let lastBtn = tmpBtn as! UIButton
            let lastView = tmpBtn.viewWithTag(4000)
            if let tmpLabel = lastView{
                let lastLabel = tmpLabel as! UILabel
                lastBtn.selected = false
                lastLabel.textColor = UIColor.grayColor()
            }
        }
        //2.设置当前选中按钮的状态
        let curLabelView = curBtn.viewWithTag(4000)
        if let tmpLabel = curLabelView{
            let curLabel = tmpLabel as! UILabel
            curBtn.selected = true
            curLabel.textColor = UIColor.orangeColor()
        }
        
        //3.选中视图控制器
        selectedIndex = curBtn.tag - 3000
        
        
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
