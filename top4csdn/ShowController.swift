//
//  ShowController.swift
//  top4csdn
//
//  Created by tech on 16/3/1.
//  Copyright © 2016年 www.miw.cn. All rights reserved.
//

import UIKit
import DJRefresh

class ShowController: UIViewController,DJRefreshDelegate {

    var info : Info!
    
    @IBOutlet weak var webView: UIWebView!
    
    private var refresh : DJRefresh!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refresh = DJRefresh(scrollView: webView.scrollView, delegate: self)
        refresh.topEnabled = true
        refresh.bottomEnabled = false
        
        title = info.title
        refresh(refresh, didEngageRefreshDirection: DJRefreshDirectionTop)
    }

    func refresh(refresh: DJRefresh!, didEngageRefreshDirection direction: DJRefreshDirection) {
        webView.loadRequest(NSURLRequest(URL: NSURL(string: info!.link)!))
        refresh.finishRefreshingDirection(direction, animation: true)
    }
}
