//
//  ViewController.swift
//  HitAndBlow
//
//  Created by hirosawak on 2015/06/12.
//  Copyright (c) 2015年 hirosawak. All rights reserved.
//

import UIKit
import QuartzCore

class ViewController: UIViewController {

    @IBOutlet weak var startBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //self.view.backgroundColor = UIColor.hexColor(0xF00000, alpha: 1.0)
        var game = HitAndBlow()

        startBtn.setTitleColor(UIColor.hexColor(0x003300,alpha: 1.0), forState: .Highlighted)
        startBtn.layer.masksToBounds = true
        startBtn.layer.cornerRadius = 5.0
        
        startBtn.titleLabel?.font = UIFont(name:"Corporate-Logo-Bold",size:17)
        startBtn.setTitle("ゲームスタート", forState: UIControlState.Normal)
        self.view.addSubview(startBtn)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

