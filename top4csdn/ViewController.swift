//
//  ViewController.swift
//  top4csdn
//
//  Created by tech on 16/2/28.
//  Copyright © 2016年 www.miw.cn. All rights reserved.
//

import UIKit
import DJRefresh
import SwiftyJSON

class ViewController: UITableViewController, MiPNetCallBack, DJRefreshDelegate {

    var category_id = "frontend"
    private var url = "http://geek.csdn.net/service/news/get_category_news_list"
    
    private var refresh : DJRefresh!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "about"), style: .Plain, target: self, action: "about")
        
        self.navigationController?.navigationBar.translucent = false
        self.tabBarController?.tabBar.translucent = false
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        refresh = DJRefresh(scrollView: tableView, delegate: self)
        refresh.topEnabled = true
        refresh.bottomEnabled = true
        
        refresh(refresh, didEngageRefreshDirection: DJRefreshDirectionTop)
    }

    func about(){
        showMessage("关于",detail: "本软件由swift编写完成，主要功能为抓取网页并进行解析。")
    }
    
    private var infos = [Info]()
    func callBack(success: Bool, data: AnyObject?) {
        refresh.finishRefreshingDirection(dir, animation: true)
        loading = false
        
        if success {
            if page == 1 {
                infos.removeAll()
            }
            infos += parse(data as! NSData)
        } else {
            showMessage("加载数据出错了，请稍后再试...")
        }
        
        tableView.reloadData()
        hideWait()
    }
    
    private var loading = false
    private var dir : DJRefreshDirection!
    private var page = 1
    private let pageSize = 20
    private var d = NSDate()
    func refresh(refresh: DJRefresh!, didEngageRefreshDirection direction: DJRefreshDirection) {
        if !loading {
            loading = true
            dir = direction
            page = direction == DJRefreshDirectionTop ? 1 : page + 1
            loadData()
        }
    }
    
    func loadData(){
        showWait()
        d = page == 1 ? NSDate() : d
        req(url, p: ["_":d.timeIntervalSince1970,"category_id":category_id,"type":"category","from":pageSize * (page - 1 ),"size":pageSize])
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infos.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseCell", forIndexPath: indexPath) as! InfoCell
        cell.setData(infos[indexPath.row])
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dest = segue.destinationViewController as? ShowController {
            let indexPath = tableView.indexPathForSelectedRow
            dest.info = infos[indexPath!.row]
        }
    }
}

