//
//  KTCSegmentCtrl.swift
//  TestKitchen
//
//  Created by NUK on 16/8/23.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit
protocol KTCSegmentCtrlDelegate:NSObjectProtocol {
    func didSelectSegCtrl(segCtrl:KTCSegmentCtrl,atIndex index:Int)
}
class KTCSegmentCtrl: UIView {
    //代理属性
    weak var delegate:KTCSegmentCtrlDelegate?

    //选中按钮的序号
    var selectIndex:Int = 0{
        didSet{
            if selectIndex != oldValue{
                selectBtnAtIndex(selectIndex,lastIndex: oldValue)
            }
            
        }
    }
    
    //下划线视图
    private var lineView:UIView?
    //titleNames 是每个按钮上显示文字的数组
    init(frame: CGRect,titleNames:[String]) {
        super.init(frame: frame)
        if titleNames.count > 0{
            //按钮的宽度
            let w:CGFloat = bounds.size.width/CGFloat(titleNames.count)
            for i in 0..<titleNames.count{
                //计算按钮的frame
                let frame = CGRectMake(CGFloat(i)*w, 0, w, bounds.size.height)
                let btn = KTCSegmentBtn(frame: frame)
                btn.configTitle(titleNames[i])
                btn.addTarget(self, action: #selector(clickBtn(_:)), forControlEvents: .TouchUpInside)
                btn.tag = 300 + i
                if i == 0{
                    btn.clicked = true
                    
                }
                addSubview(btn)
            }
            lineView = UIView.createView()
            lineView?.backgroundColor = UIColor.brownColor()
            lineView?.frame = CGRectMake(0, bounds.size.height-2, w, 2)
            addSubview(lineView!)
        }
        
    }
    //index是当前选中的序号
    //lastIndex是上次选中的序号
    func selectBtnAtIndex(index:Int,lastIndex:Int){
        let curBtn = viewWithTag(300+index)
        if curBtn?.isKindOfClass(KTCSegmentBtn) == true{
            let btn = curBtn as! KTCSegmentBtn
            btn.clicked = true
        }
        //取消上次选 中的按钮
        let lastBtn = viewWithTag(300 + lastIndex)
        if lastBtn?.isKindOfClass(KTCSegmentBtn) == true{
            let lastSegBtn = lastBtn as! KTCSegmentBtn
            //if lastSegBtn.tag != btn.tag{
            lastSegBtn.clicked = false
            //}
            
        }
        
        
        //selectIndex = index
        //修改下划线的位置
        lineView?.frame.origin.x = (lineView?.bounds.size.width)! * CGFloat(selectIndex)
    }
    func clickBtn(btn:KTCSegmentBtn){
        //btn.label?.textColor = UIColor.blackColor()
        //选中当前点击 的按钮
        //如果点击的是已经选中的按钮
        if btn.tag != 300+selectIndex{
            selectIndex = btn.tag - 300
            //selectBtnAtIndex(selectIndex)
            //其他的操作
            delegate?.didSelectSegCtrl(self, atIndex: selectIndex)
        }
        
        
        
    
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
class KTCSegmentBtn:UIControl{
    private var label:UILabel?
    var clicked:Bool?{
        didSet{
            if clicked == true{
                //选中
                label?.textColor = UIColor.blackColor()
            }else if clicked == false{
                //取消选中
                label?.textColor = UIColor.grayColor()
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        label = UILabel.createLabel(nil, font: UIFont.systemFontOfSize(20), textAlignment: NSTextAlignment.Center, textColor: UIColor.grayColor())
        label?.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height-10)
        addSubview(label!)
        
    }
    func configTitle(title:String){
        label?.text = title
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


