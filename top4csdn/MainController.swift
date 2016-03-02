//
//  MainController.swift
//  top4csdn
//
//  Created by tech on 16/3/1.
//  Copyright © 2016年 www.miw.cn. All rights reserved.
//

import UIKit

class MainController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let cats = [
            ["业界","news"],["云计算","cloud"],["大数据","bigdata"],
            ["前端","frontend"],["移动开发","mobile"],["系统网络安全","os"],
            ["IoT","iot"],["语言","language"],["数据库","database"],
            ["游戏与图像","game"],["研发工具","tools"],["软件工程","se"],
            ["程序人生","career"]
        ]
        var vcs = [UIViewController]()
        for (i,c) in EnumerateSequence(cats) {
            let vc = storyboard?.instantiateViewControllerWithIdentifier("list") as! ViewController
            vc.title = c[0]
            vc.category_id = c[1]
            vc.tabBarItem.image = UIImage(named: "ico-\(i+1)")
            let nav = UINavigationController(rootViewController: vc)
            vcs += [nav]
        }
        self.viewControllers = vcs
    }

    func applyConstraints(view:UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        let attribs = [NSLayoutAttribute.Top,.Bottom,.Left,.Right]
        for x in attribs {
            let cons = NSLayoutConstraint(item: view, attribute: x, relatedBy: .Equal, toItem: view.superview, attribute: x, multiplier: 1, constant: 0)
            view.superview?.addConstraint(cons)
        }
    }
}
