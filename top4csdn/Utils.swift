//
//  Utils.swift
//  top4csdn
//
//  Created by tech on 16/2/28.
//  Copyright © 2016年 www.miw.cn. All rights reserved.
//

import Foundation
import AFNetworking
import MBProgressHUD
import SwiftyJSON
import Kanna

//MARK: 异步网络访问回调协议
protocol MiPNetCallBack {
    func callBack(success:Bool,data:AnyObject?)
}

extension MiPNetCallBack {
    func req(url:String,p:[String:AnyObject]?){
        let manager = AFHTTPSessionManager()
        manager.requestSerializer = AFHTTPRequestSerializer()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.GET(url, parameters: p, progress: nil, success: { (task:NSURLSessionDataTask, data:AnyObject?) -> Void in
            self.callBack(true, data: data)
            }) { (task:NSURLSessionDataTask?, error:NSError) -> Void in
                self.callBack(false, data: error)
        }
    }
}

//MARK: 提示框工具
let MainView : UIView = UIApplication.sharedApplication().delegate!.window!!

func showWait(){
    MBProgressHUD.showHUDAddedTo(MainView, animated: true)
}
func hideWait(){
    MBProgressHUD.hideHUDForView(MainView, animated: true)
}

func showMessage(msg:String,detail:String?=nil,autoHide:Bool = true){
    let hud = MBProgressHUD.showHUDAddedTo(MainView, animated: true)
    hud.labelText = msg
    hud.detailsLabelText = detail
    hud.mode = .Text
    hud.removeFromSuperViewOnHide = true
    hud.hide(true, afterDelay: 3)
}

//MARK: 解析工具
func parse(data:NSData)->[Info]{
    var items = [Info]()
    let json = JSON(data: data)
    let doc = Kanna.HTML(html: json["html"].stringValue, encoding: NSUTF8StringEncoding)
    if let allimg = doc?.css("dl.geek_list") {
        print(allimg.count)
        for link in allimg {
           items.append(parseItem(link))
        }
    }
    return items
}

func parseItem(x:XMLElement)->Info{
    var info = Info()
    if let e = x.css("a.title").first {
        //print("标题：",e.text)
        info.title = e.text!
        //print("链接：",e["href"])
        info.link = e["href"]!
        
    }
    //print("图标：",x.css("img").first!["src"])
    info.icon = x.css("img").first!["src"]!
    //print("来自：",x.css("li")[0].text)
    info.from = x.css("li")[0].text!
    //print("时间：",x.css("li")[1].text)
    info.time = x.css("li")[1].text!
    //print("分享：",x.css("li")[2].text)
    info.author = x.css("li")[2].text!
    //print("======")
    return info
}

