//
//  FoodCourseViewController.swift
//  TestKitchen
//
//  Created by NUK on 16/8/25.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
class FoodCourseViewController: BaseViewController {
    var serialId:String?
    private var curPage:Int = 1
    
    //表格
    private var tbView :UITableView?
    //食材课程的属性
    private var serialModel:FoodCourseModel?
    
    //当前选择集数的序号
    private var serialIndex:Int = 0
    
    //集数的cell是合起还是展开
    private var serialIsExpand:Bool = false
    //评论数据是否有更多
    private var infoLabel:UILabel?
    
    //评论的数据 
    private var commentModel:FCComment?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        createMyNav()
        createTbView()
        downloadFoodCourseData()
        downloadCommentData()
    }

    
//    //显示tabbar
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        let appDele = UIApplication.sharedApplication().delegate as! AppDelegate
//        let ctrl = appDele.window?.rootViewController
//        if ctrl?.isKindOfClass(MainTabBarController.self) == true{
//            let mainTabBarCtrl = ctrl as! MainTabBarController
//            mainTabBarCtrl.hideTabar()
//        }
//    }
    
    //导航
    func createMyNav(){
        addNavBackBtn()
        
    }
    func createTbView(){
        automaticallyAdjustsScrollViewInsets = false
        tbView = UITableView(frame: CGRectMake(0, 64, kScreenWidth, kScreenHeight-64), style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        tbView?.separatorStyle = .None
        view.addSubview(tbView!)
    }
    func downloadFoodCourseData(){
        
        //methodName=CourseSeriesView&series_id=22&token=&user_id=&version=4.32
        if serialId == nil {
            return
        }
        var dict = Dictionary<String,String>()
        dict["methodName"] = "CourseSeriesView"
        dict["series_id"] = serialId!
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.type = KTCDownloaderType.FoodCourse
        downloader.postWithUrl(kHostUrl, params: dict)
        
    }
    
    //下载 评论的数据
    func downloadCommentData(){
        //methodName=CommentList&page=1&relate_id=22&size=10&token=&type=2&user_id=&version=4.32
        //methodName=CommentList&page=2&relate_id=22&size=10&token=&type=2&user_id=&version=4.32
        
        var params = Dictionary<String,String>()
        params["methodName"] = "CommentList"
        params["page"] = "\(curPage)"
        params["relate_id"] = serialId
        params["size"] = "10"
        params["type"] = "2"
        let downloader = KTCDownloader()
        downloader.type = KTCDownloaderType.FoodCourseComment
        downloader.delegate = self
        downloader.postWithUrl(kHostUrl, params: params)
        
        
        
    }
    //评论
    func commentAction(){
        
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

extension FoodCourseViewController:KTCDownloaderDelegate{
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        print(error)
    }
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?) {
        if let jsonData = data{
            if downloader.type == KTCDownloaderType.FoodCourse{
                //视频数据
                let model = FoodCourseModel.parseModelWithData(jsonData)
                self.serialModel = model
                
                
                dispatch_async(dispatch_get_main_queue(), {
                    [weak self]in
                    self!.tbView?.reloadData()
                    let array = self!.serialModel?.data?.series_name?.componentsSeparatedByString("#")
                    if array?.count > 1{
                        self!.addNavTitle(array![1])
                    }
                })
            }else if downloader.type == KTCDownloaderType.FoodCourseComment{
                //评论数据
                let model = FCComment.parseWithData(jsonData)
                if curPage == 1{
                    commentModel = model
                }else{
                    //加载更多
                    let mutableArray = NSMutableArray(array: (commentModel?.data?.data)!)
                    mutableArray.addObjectsFromArray((model.data?.data)!)
                    let array = NSArray(array: mutableArray)
                    commentModel?.data?.data = array as? [FCCommentDetail]
                }
//                commentModel = FCComment.parseWithData(jsonData)
                dispatch_async(dispatch_get_main_queue(), {
                    [weak self]in
            
                    //判断是否有更多
                    var hasMore = false
                    if self!.commentModel?.data?.total != nil{
                        
                        let total = NSString(string: (self?.commentModel?.data?.total)!).integerValue
                        if total > self?.commentModel?.data?.data?.count{
                            hasMore = true
                        }
                        
                    }
                    //创建label
                    if self!.infoLabel == nil{
                        self!.infoLabel = UILabel.createLabel(nil, font: UIFont.systemFontOfSize(16), textAlignment: NSTextAlignment.Center, textColor: UIColor.blackColor())
                        self!.infoLabel?.frame = CGRectMake(0, 0, kScreenWidth, 40)
                        self!.infoLabel?.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
                        self!.tbView?.tableFooterView = self!.infoLabel
                    }
                    
                    if hasMore{
                        self!.infoLabel?.text = "下拉加载更多"
                    }else{
                        self!.infoLabel?.text = "没有更多了!"
                    }
                    
                    //self?.tbView?.reloadSections(NSIndexSet(index:1), withRowAnimation: .None)
                    self!.tbView?.reloadData()
                })
                
                
                
            }
        }
    }
}

extension FoodCourseViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNum = 0
        if section == 0{
            //食材课程
            if serialModel?.data?.data?.count > 0 {
                rowNum = 3
            }
            
        }else if section == 1{
            if let count = commentModel?.data?.data?.count{
                rowNum = count
            }
            
        }
        
        return rowNum
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height:CGFloat = 0
        if indexPath.section == 0{
            if indexPath.row == 0{
                //视图的高度
                height = 160
            }else if indexPath.row == 1{
                //课程和描述
                if serialModel?.data?.data?.count > 0{
                    let model = serialModel?.data?.data![serialIndex]
                    height = FCCourseCell.heightWithModel(model!)
                    
                }
                
            }else if indexPath.row == 2{
                //集数
                height = FCSerialCell.heightWithNum((serialModel?.data?.data!.count)!,isExpand: serialIsExpand)
            }
            
        }else if indexPath.section == 1{
            height = 80
        }
        return height
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell? = UITableViewCell()
        
        if indexPath.section == 0{
            let dataModel = serialModel?.data?.data![serialIndex]
            if indexPath.row == 0{
                //视频的cell 
                
                cell = createVideoCellForTableView(tableView, atIndexPath: indexPath, withModel: dataModel!)
                
                
            }else if indexPath.row == 1{
                cell = createCourseCellForTableView(tableView, atIndexPath: indexPath, withModel: dataModel!)
            }else if indexPath.row == 2{
                //集数
                cell = createSerialCellForTableView(tableView, atIndextPath: indexPath, withModel: serialModel!)
            }
        }else if indexPath.section == 1{
            cell = createCommentCellForTableView(tableView, atIndextPath: indexPath, withModel: (commentModel?.data?.data![indexPath.row])!)
        }
        
        cell?.selectionStyle = .None
        return cell!
    }
    //创建cell
    /*创建视频的cell*/
    func createVideoCellForTableView(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withModel model:FoodCourseSerialModel)->FCVideoCell{
        let cellId = "videoCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)as? FCVideoCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("FCVideoCell", owner: nil, options: nil).last as? FCVideoCell
        }
        cell?.model = model
        
        cell?.videoClosure = {
            [weak self]
            urlString in
            let url = NSURL(string: urlString)
            let player = AVPlayer(URL: url!)
            let playerCtrl = AVPlayerViewController()
            playerCtrl.player = player
            player.play()
            self!.presentViewController(playerCtrl, animated: true, completion: nil)
        }
        
        return cell!
    }
    /*创建课程标题和描述文字的cell*/
    func createCourseCellForTableView(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withModel model:FoodCourseSerialModel)->FCCourseCell{
        let cellId = "courseCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)as? FCCourseCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("FCCourseCell", owner: nil, options: nil).last as? FCCourseCell
        }
        cell?.model = model
        
        return cell!
        
    }
    //创建一共有多少集的cell
    func createSerialCellForTableView(tableView:UITableView,atIndextPath indexPath:NSIndexPath,withModel model:FoodCourseModel)->FCSerialCell{
        let cellId = "serialCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCSerialCell
        if cell == nil {
            cell = FCSerialCell(style: .Default, reuseIdentifier: cellId)
        }
        cell?.isExpand = serialIsExpand
        cell?.num = model.data?.data?.count
        
        cell?.delegate = self
        cell?.selectIndex = serialIndex
        
        return cell!
    }
    //评论的cell
    func createCommentCellForTableView(tableView:UITableView,atIndextPath indexPath:NSIndexPath,withModel model:FCCommentDetail)->FCCommentCell{
        let cellId = "commentCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as? FCCommentCell
        if cell == nil
        {
            cell = NSBundle.mainBundle().loadNibNamed("FCCommentCell", owner: nil, options: nil).last as? FCCommentCell
        }
        cell?.model = model
        return cell!
        
    }
    
    
}
extension FoodCourseViewController:FCSerialCellDelegate{
    func didSelectSerialAtIndex(index: Int) {
        //修改当前选择的集数的序号
        serialIndex = index
        //刷新表格的第一个section
        
        tbView?.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Automatic)
    }
    
    func changeExpandState(isExpand: Bool) {
        serialIsExpand = isExpand
        //刷新表格
        
        tbView?.reloadRowsAtIndexPaths([NSIndexPath(forRow: 2, inSection: 0)], withRowAnimation: .Automatic)
    }
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if commentModel?.data?.total != nil{
            let totalCount = NSString(string:(commentModel?.data?.total)!).integerValue
            if  totalCount == commentModel?.data?.data?.count{
                return
            }
        }
        
        let offset:CGFloat = 40
        if scrollView.contentOffset.y >= scrollView.contentSize.height - scrollView.bounds.size.height-offset{
            //下载下一页的数据
            curPage += 1
            downloadCommentData()
        }
        let h:CGFloat = 70
        if scrollView.contentOffset.y > h{
            scrollView.contentInset = UIEdgeInsetsMake(-h, 0, 0, 0)
        }else if scrollView.contentOffset.y > 0{
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1{
            let bgView = UIView.createView()
            bgView.frame = CGRectMake(0, 0, kScreenWidth, 60)
            bgView.backgroundColor = UIColor.whiteColor()
            
            if commentModel?.data?.total != nil{
                let str = "\((commentModel?.data?.total)!)条评论"
                let numLabel = UILabel.createLabel(str, font: UIFont.systemFontOfSize(18), textAlignment: .Left, textColor: UIColor.grayColor())
                numLabel.frame = CGRectMake(20, 4, 160, 20)
                bgView.addSubview(numLabel)
            }
            let btn = UIButton.createBtn("我要评论", bgImageName: nil, selectBgImageName: nil, target: self, action: #selector(commentAction))
            btn.frame = CGRectMake(20, 34, kScreenWidth - 20*2, 30)
            btn.backgroundColor = UIColor.orangeColor()
            btn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            btn.layer.cornerRadius = 6
            btn.layer.masksToBounds = true
            bgView.addSubview(btn)
            
            return bgView
        }
        return nil
    }
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 70{
            return 70
        }
        return 0
    }
}


