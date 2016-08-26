//
//  CookBookViewController.swift
//  TestKitchen
//
//  Created by NUK on 16/8/15.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class CookBookViewController: KTCHomeViewController {
    
    //滚动视图
    //
    var scrollView:UIScrollView?
    //食材首页的推荐视图
    private var recommendView:CBRecommendView?
    //首页的食材视图
    private var foodView:CBMaterialView?
    //首页的分类视图
    private var categoryView:CBMaterialView?
    
    //导航的标题视图
    private var segCtrl :KTCSegmentCtrl?

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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        createMyNav()
        createHomePageView()
        downloadRecommendData()
        downloadFoodData()
        downloadCategoryData()
    }
    
    //初始化视图
    func createHomePageView(){
        automaticallyAdjustsScrollViewInsets = false
        //创建一个滚动视图
        scrollView = UIScrollView()
        view.addSubview(scrollView!)
        scrollView?.delegate = self
        scrollView!.pagingEnabled = true
        scrollView!.showsHorizontalScrollIndicator = false
        
        scrollView!.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo((self?.view)!).inset(UIEdgeInsetsMake(64, 0, 49, 0))
        }
        //创建容器视图
        let containerView = UIView.createView()
        scrollView!.addSubview(containerView)
        containerView.snp_makeConstraints {
            [weak self]
            (make) in
            make.edges.equalTo(self!.scrollView!)
            make.height.equalTo(self!.scrollView!)
        }
        //1.推荐视图
        recommendView = CBRecommendView()
        containerView.addSubview(recommendView!)
        recommendView?.snp_makeConstraints(closure: {
            (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo(containerView)
        })
        
        //3.2.食材
        foodView = CBMaterialView()
        foodView?.backgroundColor = UIColor.redColor()
        containerView.addSubview(foodView!)
        //约束
        foodView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo((recommendView?.snp_right)!)
        })
        
        //3.3.分类
        categoryView = CBMaterialView()
        categoryView!.backgroundColor = UIColor.greenColor()
        containerView.addSubview(categoryView!)
        categoryView?.snp_makeConstraints(closure: { (make) in
            make.top.bottom.equalTo(containerView)
            make.width.equalTo(kScreenWidth)
            make.left.equalTo((foodView?.snp_right)!)
        })
        
        //4.修改容器视图的大小
        containerView.snp_makeConstraints { (make) in
            make.right.equalTo((categoryView?.snp_right)!)
        }
        
        
    }
    
    //下载推荐的数据
    func downloadRecommendData(){
        //methodName=SceneHome&token=&user_id=&version=4.5
        let dict = ["methodName":"SceneHome"]
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.type = KTCDownloaderType.Recommend
        downloader.postWithUrl(kHostUrl, params: dict)
    }
    //下载食材的数据
    func downloadFoodData(){
        //methodName=MaterialSubtype&token=&user_id=&version=4.5
        let dict = ["methodName":"MaterialSubtype"]
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.type = KTCDownloaderType.FoodMaterial
        downloader.postWithUrl(kHostUrl, params: dict)
    }
    func downloadCategoryData(){
        //methodName=CategoryIndex&token=&user_id=&version=4.32
        let dict = ["methodName":"CategoryIndex"]
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.type = KTCDownloaderType.Category
        downloader.postWithUrl(kHostUrl, params: dict)
        
        
        
    }
    func createMyNav(){
        //标题位置
        segCtrl = KTCSegmentCtrl(frame: CGRectMake(80, 0, kScreenWidth - 80 * 2, 44), titleNames: ["推荐","食材","分类"])
        segCtrl?.delegate = self
        navigationItem.titleView = segCtrl
        
        addNavBtn("saoyisao", target: self, action: #selector(scanAction), isLeft: true)
        addNavBtn("search", target: self, action: #selector(searchAction), isLeft: false)
    }
    func scanAction(){
        
    }
    func searchAction(){
        
    }

    //MARK:首页推荐的方法
    //app://food_course_series#98#
    //食材的课程分集显示
    func gotoFoodCoursePage(link:String){
        let startRange = NSString(string: link).rangeOfString("#")
        let endRange = NSString(string: link).rangeOfString("#", options: NSStringCompareOptions.BackwardsSearch, range: NSMakeRange(0, link.characters.count), locale: nil)
        let id = NSString(string: link).substringWithRange(NSMakeRange(startRange.location+1, endRange.location-startRange.location-1))
        let foodCourseCtrl = FoodCourseViewController()
        foodCourseCtrl.serialId = id
        navigationController?.pushViewController(foodCourseCtrl, animated: true)
    }
    
    //MARK:首页推荐的方法
    //显示首页推荐的数据
    func showRecommendData(model:CBRecommendModel){
        recommendView?.model = model
        //点击事件
        recommendView?.clickClosure = {
            [weak self]
            (title:String?,link:String)in
            if link.hasPrefix("app://food_course_series") == true{
                //app://food_course_series#98#
                //食材的课程分集显示
                
                self?.gotoFoodCoursePage(link)
                
                
                
            }
            
        }
    }
    //MARK:首页食材的方法
    
    
    //MARK:首页分类的方法
    
    
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
//MARK:KTCDownloader下载的代理
extension CookBookViewController:KTCDownloaderDelegate{
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        print(error)
    }
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?) {
        if downloader.type == KTCDownloaderType.Recommend{
            if let jsonData = data{
                let model = CBRecommendModel.parseModel(jsonData)
                //显示
                dispatch_async(dispatch_get_main_queue(), {
                    [weak self] in
                
                    self?.showRecommendData(model)
                    
                    
                    //点击事件
                    
                    })
            }
        }else if downloader.type == KTCDownloaderType.FoodMaterial{
            if let jsonData = data{
                let model = CBMaterialModel.parseJson(jsonData)
                dispatch_async(dispatch_get_main_queue(), { 
                    [weak self]in
                    self!.foodView?.model = model
                })
            }
        }else if downloader.type == .Category{
            if let jsonData = data{
                
                let model = CBMaterialModel.parseJson(jsonData)
                dispatch_async(dispatch_get_main_queue(), { 
                    [weak self]in
                    self?.categoryView?.model = model
                })
            }
        }
        
    }
}
extension CookBookViewController:KTCSegmentCtrlDelegate{
    func didSelectSegCtrl(segCtrl: KTCSegmentCtrl, atIndex index: Int) {
        scrollView?.setContentOffset(CGPointMake(kScreenWidth*CGFloat(index), 0), animated: true)
        
    }
}
extension CookBookViewController:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        segCtrl?.selectIndex = index
    }
}








