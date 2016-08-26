//
//  FoodCourseModel.swift
//  TestKitchen
//
//  Created by NUK on 16/8/25.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit
import SwiftyJSON
class FoodCourseModel: NSObject {

    var code:String?
    var msg:String?
    var version:String?
    var timestamp:NSNumber?
    var data:FoodCourseDataModel?
    
    class func parseModelWithData(data:NSData)->FoodCourseModel{
        let model = FoodCourseModel()
        let jsonData = JSON(data:data)
        model.code = jsonData["code"].string
        model.msg = jsonData["msg"].string
        model.version = jsonData["version"].string
        model.timestamp = jsonData["timestamp"].number
        
        model.data = FoodCourseDataModel.parseJson(jsonData["data"])
        
        return model
        
        
        
    }
    
    
}
class FoodCourseDataModel:NSObject{
    
    var series_id:String?
    var series_name:String?
    var series_title:String?
    var create_time:String?
    var last_update:String?
    var order_no:String?
    var tag:String?
    var episode:NSNumber?
    var series_image:String?
    var share_title:String?
    var share_description:String?
    var share_image:String?
    var album:String?
    var album_logo:String?
    var relate_activity:String?
    var data:Array<FoodCourseSerialModel>?
    var play:NSNumber?
    var share_url:String?
    
    
    class func parseJson(jsonData:JSON)->FoodCourseDataModel{
    
        let model = FoodCourseDataModel()
        model.series_id = jsonData["series_id"].string
        model.series_name = jsonData["series_name"].string
        model.series_title = jsonData["series_title"].string
        model.create_time = jsonData["create_time"].string
        model.last_update = jsonData["create_time"].string
        model.order_no = jsonData["order_no"].string
        model.tag = jsonData["tag"].string
        model.episode = jsonData["episode"].number
        model.series_image = jsonData["series_image"].string
        model.share_title = jsonData["share_title"].string
        model.share_description = jsonData["share_description"].string
        model.share_image = jsonData["share_image"].string
        
        model.album = jsonData["album"].string
        model.album_logo = jsonData["album_logo"].string
        model.relate_activity = jsonData["relate_activity"].string
        
        
        let dataJsonArray = jsonData["data"]
        var array = Array<FoodCourseSerialModel>()
        for (_,subJson) in dataJsonArray{
            let model = FoodCourseSerialModel.parseJson(subJson)
            array.append(model)
        }
        model.data = array
        
        
        model.play = jsonData["play"].number
        model.share_url = jsonData["share_url"].string
        return model
        
        
    }
    
    
}
class FoodCourseSerialModel:NSObject{
    
    var course_id:NSNumber?
    var course_video:String?
    var episode:NSNumber?
    var course_name:String?
    var course_subject:String?
    var course_image:String?
    var ischarge:String?
    var price:String?
    var video_watchcount:NSNumber?
    var course_introduce:String?
    var is_collect:NSNumber?
    var is_like:NSNumber?
    
    
    class func parseJson(jsonData:JSON)->FoodCourseSerialModel{
        let model = FoodCourseSerialModel()
        model.course_id = jsonData["course_id"].number
        model.course_video = jsonData["course_video"].string
        model.episode = jsonData["episode"].number
        model.course_name = jsonData["course_name"].string
        model.course_subject = jsonData["course_subject"].string
        model.course_image = jsonData["course_image"].string
        model.video_watchcount = jsonData["video_watchcount"].number
        model.ischarge = jsonData["ischarge"].string
        model.price = jsonData["price"].string
        model.course_introduce = jsonData["course_introduce"].string
        model.is_collect = jsonData["is_collect"].number
        model.is_like = jsonData["is_like"].number
        
        
        
        
        return model
    }
    

}





