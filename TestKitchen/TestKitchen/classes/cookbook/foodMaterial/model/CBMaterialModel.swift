//
//  CBMaterialModel.swift
//  TestKitchen
//
//  Created by NUK on 16/8/23.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit
import SwiftyJSON
class CBMaterialModel: NSObject {

    var code:String?
    var msg:String?
    var version:String?
    var timestamp:NSNumber?
    var data:CBMaterialDataModel?
    class func parseJson(data:NSData)->CBMaterialModel{
        let jsonData = JSON(data:data)
        let model = CBMaterialModel()
        model.code = jsonData["code"].string
        model.msg = jsonData["msg"].string
        model.version = jsonData["version"].string
        model.timestamp = jsonData["timestamp"].number
        model.data = CBMaterialDataModel.parseJson(jsonData["data"])
        return model
    }
    
}
class CBMaterialDataModel:NSObject{
    var id:String?
    var text:String?
    var image:String?
    var data:Array<CBMaterialTypeModel>?
    
    class func parseJson(jsonData:JSON)->CBMaterialDataModel{
        let model = CBMaterialDataModel()
        model.id = jsonData["id"].string
        model.text = jsonData["text"].string
        model.image = jsonData["image"].string
        var dataArray = Array<CBMaterialTypeModel>()
        let data = jsonData["data"]
        for (_,subJson) in data{
            let model = CBMaterialTypeModel.parseJson(subJson)
            dataArray.append(model)
            
        }
        model.data = dataArray
        return model
        
    }
    
}

class CBMaterialTypeModel:NSObject{
    var id:String?
    var text:String?
    var image:String?
    var data:Array<CBMaterialSubtypeModel>?
    class func parseJson(jsonData:JSON)->CBMaterialTypeModel{
        let model = CBMaterialTypeModel()
        model.id = jsonData["id"].string
        model.text = jsonData["text"].string
        model.image = jsonData["image"].string
        
        var dataArray = Array<CBMaterialSubtypeModel>()
        let data = jsonData["data"]
        for (_,subJson) in data{
            let model = CBMaterialSubtypeModel.parseJson(subJson)
            dataArray.append(model)
            
        }
        model.data = dataArray
        
        return model
    }
    
}
class CBMaterialSubtypeModel: NSObject {
    var id:String?
    var text:String?
    var image:String?
    class func parseJson(jsonData:JSON)->CBMaterialSubtypeModel{
        let model = CBMaterialSubtypeModel()
        model.id = jsonData["id"].string
        model.text = jsonData["text"].string
        model.image = jsonData["image"].string
        
        return model
    }
}



