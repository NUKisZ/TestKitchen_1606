//
//  CBRecommendModel.swift
//  TestKitchen
//
//  Created by NUK on 16/8/16.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class CBRecommendModel: NSObject {
    var code:NSNumber?
    var msg:Bool?
    var version:String?
    var timestamp:NSNumber?
    var data:CBRecommendDataModel?
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    
    
}
class CBRecommendDataModel: NSObject {
    var banner:Array<CBRecommendBannerModel>?
    var widgetList:Array<CBRecommendWidgetListModel>?
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}

class CBRecommendBannerModel: NSObject {
    var banner_id:NSNumber?
    var banner_title:String?
    var banner_picture:String?
    
    var banner_link:String?
    var is_link:NSNumber?
    var refer_key:NSNumber?
    
    var type_id:NSNumber?
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
}


class  CBRecommendWidgetListModel: NSObject {
    var widget_id:NSNumber?
    var widget_type:NSNumber?
    var title:String?
    var title_link:String?
    var desc:String?
    var widget_data:NSArray?
    
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}

class  CBRecommendWidgetDataModel: NSObject {
    var id:NSNumber?
    var type:String?
    var content:String?
    var link:String?
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}








