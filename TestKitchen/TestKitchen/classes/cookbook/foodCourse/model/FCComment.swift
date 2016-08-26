//
//  FCComment.swift
//  TestKitchen
//
//  Created by NUK on 16/8/26.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit
import SwiftyJSON
class FCComment: NSObject {
    
    var code:String?
    var msg:String?
    var version:String?
    var timestamp:NSNumber?
    var data:FCCommentData?
    /*
    class func parseJson(data:NSData){
        do{
            let jsonData = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers)
            let model = FCComment()
            if jsonData.isKindOfClass(NSDictionary.self){
                let dict = jsonData as! Dictionary<String,AnyObject>
                model.setValuesForKeysWithDictionary(dict)
                let dataModel = dict["data"]
                
            }
            
        }catch{
            print(error)
        }
        
        
        
    }*/
    class func parseWithData(data:NSData)->FCComment{
        let model = FCComment()
        let jsonData = JSON(data:data)
        model.code = jsonData["code"].string
        model.msg = jsonData["msg"].string
        model.version = jsonData["version"].string
        model.timestamp = jsonData["timestamp"].number
        model.data = FCCommentData.parseJson(jsonData["data"])
        return model
    }

}

class FCCommentData:NSObject{
    var page:String?
    var size:String?
    var total:String?
    var count:String?
    var data:Array<FCCommentDetail>?
    class func parseJson(jsonData:JSON)->FCCommentData{
        let model = FCCommentData()
        model.page = jsonData["page"].string
        model.size = jsonData["size"].string
        model.total = jsonData["total"].string
        model.count = jsonData["count"].string
        //model.page = jsonData["page"].string
        
        var array = Array<FCCommentDetail>()
        for (_,subJson)in jsonData["data"]{
            let model = FCCommentDetail.parseModel(subJson)
            array.append(model)
        }
        model.data = array
        
        return model
    }
    
}


class FCCommentDetail:NSObject{
    var id:String?
    var user_id:String?
    var type:String?
    var relate_id:String?
    
    var content:String?
    var create_time:String?
    var parent_id:String?
    var parents:Array<FCCommentDetail>?
    var nick:String?
    var head_img:String?
    var istalent:NSNumber?
    
    
    class func parseModel(jsonData:JSON)->FCCommentDetail{
        let model = FCCommentDetail()
        
        model.id = jsonData["id"].string
        model.user_id = jsonData["user_id"].string
        model.type = jsonData["type"].string
        model.relate_id = jsonData["relate_id"].string
        model.content = jsonData["content"].string
        model.create_time = jsonData["create_time"].string
        model.parent_id = jsonData["parent_id"].string
        model.nick = jsonData["nick"].string
        model.head_img = jsonData["head_img"].string
        model.istalent = jsonData["istalent"].number
        
        
        let parents = jsonData["parents"]
        var array = Array<FCCommentDetail>()
        for (_,subJson) in parents{
            let model = FCCommentDetail.parseModel(subJson)
            array.append(model)
        }
        model.parents = array
        
        
        return model
    }
    
    
    
}



