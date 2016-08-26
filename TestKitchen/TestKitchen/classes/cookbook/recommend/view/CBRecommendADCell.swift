//
//  CBRecommendADCell.swift
//  TestKitchen
//
//  Created by NUK on 16/8/17.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit
class CBRecommendADCell: UITableViewCell {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    

    //图片的点击事件
    var clickClosure:CBCellClosure?
    
    var bannerArray:Array<CBRecommendBannerModel>?{
        didSet{
            //显示UI
            showData()
        }
    }
    
    func showData(){
        for sub in scrollView.subviews{
            sub.removeFromSuperview()
        }
        
        let cnt = bannerArray?.count
        if cnt > 0{
            //
            //0.添加一个容器视图
            let containerView = UIView.createView()
            
            for oldSub in scrollView.subviews{
                oldSub.removeFromSuperview()
            }
            scrollView.addSubview(containerView)
            //设置约束
            containerView.snp_makeConstraints(closure: {
                [weak self]
                (make) in
                make.edges.equalTo(self!.scrollView)
                make.height.equalTo(self!.scrollView)
                
            })
            
            var lastView:UIView? = nil
            for i in 0..<cnt!{
                //1.模型对象
                let model = bannerArray![i]
                //2.创建图片
                //循环创建图片
                let tmpImageView = UIImageView.createImageView(nil)
                //在线加载图片
                /*
                 第一个参数:图片网址的URL
                 第二个:默认图片
                 第三个:选项
                 第四个:可以获取下载的进度
                 第五个:下载结束的一些操作
                 */
                let url = NSURL(string: model.banner_picture!)
                let image = UIImage(named: "sdefaultImage")
                tmpImageView.kf_setImageWithURL(url, placeholderImage: image, optionsInfo: nil, progressBlock: nil, completionHandler: nil)
                containerView.addSubview(tmpImageView)
                
                
                //添加手势
                tmpImageView.userInteractionEnabled = true
                tmpImageView.tag = 500 + i
                let g = UITapGestureRecognizer(target: self, action: #selector(tapImage(_:)))
                tmpImageView.addGestureRecognizer(g)
                
                
                //约束
                tmpImageView.snp_makeConstraints(closure: { (make) in
                    make.top.bottom.equalTo(containerView)
                    make.width.equalTo(kScreenWidth)
                    if i == 0{
                        make.left.equalTo(containerView)
                    }else{
                        make.left.equalTo((lastView?.snp_right)!)
                    }
                })
                lastView = tmpImageView
            }
            
            //修改容器视图的约束
            containerView.snp_makeConstraints(closure: { (make) in
                make.right.equalTo((lastView?.snp_right)!)
            })
            //修改分布控件
            pageControl.numberOfPages = cnt!
            pageControl.addTarget(self, action: #selector(pageAction(_:)), forControlEvents: .TouchUpInside)
            scrollView.pagingEnabled = true
            scrollView.delegate = self
            
        }
        
    }
    
    func tapImage(g:UIGestureRecognizer){
        let index = (g.view?.tag)! - 500
        
        //获取模型对象
        let imageModel = bannerArray![index]
        
        //要将点击事件传到视图控制器
        clickClosure!(nil,imageModel.banner_link!)
        
    }
    
    func pageAction(index:UIPageControl){
        print(index.currentPage)
    }
    
    //创建cell的方法
    /*
     tableView:cell所在的表格
     indexPath:cell在表格的位置
     model:cell的显示数据
     cellClosure:图片的点击事件
     
     */
    class func createADCellFor(tableView:UITableView,atIndexPath indexPath:NSIndexPath,withModel model:CBRecommendModel,cellClosure:CBCellClosure?)->UITableViewCell{
        let cellId = "recommendADCellId"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellId)as? CBRecommendADCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("CBRecommendADCell", owner: nil, options: nil).last as? CBRecommendADCell
        }
        
        cell?.bannerArray = model.data?.banner
        cell?.clickClosure = cellClosure
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
extension CBRecommendADCell:UIScrollViewDelegate{
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        pageControl.currentPage = index
    }
}






