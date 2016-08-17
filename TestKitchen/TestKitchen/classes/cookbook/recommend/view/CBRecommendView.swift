//
//  CBRecommendView.swift
//  TestKitchen
//
//  Created by NUK on 16/8/17.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class CBRecommendView: UIView {
    //显示数据
    var model:CBRecommendModel?{
        didSet{
            
            tbView?.reloadData()
        }
    }

    //表格
    private var tbView:UITableView?
    
    init() {
        super.init(frame: CGRectZero)
        //创建表格视图
        tbView = UITableView(frame: CGRectZero, style: .Plain)
        tbView?.delegate = self
        tbView?.dataSource = self
        tbView?.separatorStyle = .None
        addSubview(tbView!)
        //约束
        tbView?.snp_makeConstraints(closure: {
            [weak self]
            (make) in
            make.edges.equalTo(self!)
        })
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
extension CBRecommendView:UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //广告一个分组
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rowNum = 0
        if section == 0{
            //广告的数据
            if model?.data?.banner?.count>0{
                rowNum = 1
            }
        }
        return rowNum
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height:CGFloat = 0
        if indexPath.section == 0 {
            if model?.data?.banner?.count > 0{
                height = 160
            }
        }
        
        
        return height
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()
        if indexPath.section == 0{
            if model?.data?.banner?.count > 0 {
                cell = CBRecommendADCell.createADCellFor(tableView, atIndexPath: indexPath, withModel: model!)
            }
        }
        
        return cell
    }
    
}




