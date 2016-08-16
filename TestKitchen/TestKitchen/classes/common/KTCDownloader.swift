//
//  KTCDownloader.swift
//  TestKitchen
//
//  Created by NUK on 16/8/16.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit
import Alamofire

public enum KTCDownloaderType:Int{
    case Default = 10
}


protocol KTCDownloaderDelegate:NSObjectProtocol {
    //下载失败
    func downloader(downloader:KTCDownloader,didFailWithError error:NSError)
    //下载成功
    func downloader(downloader:KTCDownloader,didFinishWithData data:NSData?)
}
class KTCDownloader: NSObject {

    //代理属性
    //一定要用weak修饰
    weak var delegate:KTCDownloaderDelegate?
    //类型,用来区分不同下载
    var type:KTCDownloaderType = .Default
    //Post请求下载数据的方法
    func postWithUrl(urlString:String,params:Dictionary<String,String>?){
        
        Alamofire.request(.POST, urlString, parameters: params, encoding: ParameterEncoding.URL, headers: nil).responseData {
            (response) in
            switch response.result{
            case .Failure(let error):
                self.delegate?.downloader(self, didFailWithError: error)
            case .Success:
                self.delegate?.downloader(self, didFinishWithData: response.data)
            }
        }
        
    }
    
}
