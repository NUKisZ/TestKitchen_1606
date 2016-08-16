//
//  CookBookViewController.swift
//  TestKitchen
//
//  Created by NUK on 16/8/15.
//  Copyright © 2016年 NUK. All rights reserved.
//

import UIKit

class CookBookViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.redColor()
        createMyNav()
        downloadRecommendData()
    }
    //下载推荐的数据
    func downloadRecommendData(){
        //methodName=SceneHome&token=&user_id=&version=4.5
        let dict = ["methodName":"SceneHome","token":"","user_id":"","version":"4.5"]
        let downloader = KTCDownloader()
        downloader.delegate = self
        downloader.postWithUrl(kHostUrl, params: dict)
    }
    
    
    func createMyNav(){
        addNavBtn("saoyisao", target: self, action: #selector(scanAction), isLeft: true)
        addNavBtn("search", target: self, action: #selector(searchAction), isLeft: false)
    }
    func scanAction(){
        
    }
    func searchAction(){
        
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
//MARK:KTCDownloader下载的代理
extension CookBookViewController:KTCDownloaderDelegate{
    func downloader(downloader: KTCDownloader, didFailWithError error: NSError) {
        print(error)
    }
    func downloader(downloader: KTCDownloader, didFinishWithData data: NSData?) {
        let str = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print(str!)
    }
}










