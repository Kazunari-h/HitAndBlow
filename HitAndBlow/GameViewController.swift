//
//  GameViewController.swift
//  HitAndBlow
//
//  Created by hirosawak on 2015/06/12.
//  Copyright (c) 2015年 hirosawak. All rights reserved.
//

import UIKit
import QuartzCore


class GameViewController: UIViewController {

    let xBtnCont = 3
    let yBtnCont = 4
    
    let BtnMargin : Double = 10
    
    let screenWidth  : Double = Double(UIScreen.mainScreen().bounds.size.width)
    let screenHeight : Double = Double(UIScreen.mainScreen().bounds.size.height)
    
    var game = HitAndBlow()
    var inpBox : [Int] = [-1,-1,-1,-1]
    var cursor : Int = 0
    
    var limitNum : Int = 4

    var label = UILabel()
    var messBox = UILabel()
    var prvBox = UILabel()
    
    var status : String = ""

    var Box1 = UILabel()
    var Box2 = UILabel()
    var Box3 = UILabel()
    var Box4 = UILabel()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.view.backgroundColor = UIColor.hexColor(0x000000, alpha: 1.0)
        setBtn()
        setLabel(label,x: 1,text: "残り\(limitNum)回")
        setLabel(messBox,x: 2,text: "4つの数字を押して！")
        setLabel(prvBox, x: 3, text: "")
        setInpBox()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setInpBox(){
        setNumLabel(Box1, x: 0, text: "")
        setNumLabel(Box2, x: 1, text: "")
        setNumLabel(Box3, x: 2, text: "")
        setNumLabel(Box4, x: 3, text: "")
    }
    

    func setNumLabel(viewLabel:UILabel,x:Int,text:String){
        var width          =  (screenWidth - BtnMargin * 5) / 4
        var height:Double  =  width
        viewLabel.frame =
            CGRect(x: BtnMargin + (height+BtnMargin) * Double(x),y: screenHeight/2 - height-20 ,width: width,height: height)
        viewLabel.text  = text
        viewLabel.textAlignment = NSTextAlignment.Center
        viewLabel.backgroundColor = UIColor.hexColor(0xcccccc, alpha: 1.0)
        self.view.addSubview(viewLabel)
    }

    func displayNum(){
        var count = 0
        for i in inpBox {
            var text : String
            if i != -1 {
                text = toString(i)
            }else{
                text = ""
            }
            
            switch count {
            case 0 :
                Box1.text = text
            case 1 :
                Box2.text = text
            case 2 :
                Box3.text = text
            default :
                Box4.text = text
            }
            count++
        }
        
        label.text = "残り\(limitNum)回"
    }
    
    func setLabel(viewLabel:UILabel,x:Int,text:String){
        var width          =  screenWidth - BtnMargin*2
        var height:Double  =  30
        viewLabel.frame = CGRect(x: BtnMargin, y: (height + BtnMargin) * Double(x)  , width: width , height: height)
        viewLabel.text  = text
        viewLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(viewLabel)
    }
    
    func setBtn(){
        var NumBtnWidht  = (screenWidth - (BtnMargin * Double(xBtnCont+1)))/Double(xBtnCont)
        var NumBtnHeight = (screenHeight/2 - (BtnMargin * Double(yBtnCont+1)))/Double(yBtnCont)
        
        let title:[String] = [
            "7" , "8" , "9" ,
            "4" , "5" , "6" ,
            "1" , "2" , "3" ,
            "SET" , "0", "CL" 
        ]
        
        for x in 0..<xBtnCont {
            for y in 0..<yBtnCont {
                var CountBtn = y * xBtnCont + x
                var button = UIButton()
                var xPosition = NumBtnWidht * Double(x) + BtnMargin * Double(x + 1)
                var yPosition = NumBtnHeight * Double(y) + BtnMargin * Double(y + 1) + (screenHeight)/2
                button.frame = CGRect(x: xPosition,y: yPosition,width: NumBtnWidht,height: NumBtnHeight)
                var gra = CAGradientLayer()
                gra.frame = button.bounds
                var newColor1 = UIColor.hexColor(0x666666,alpha: 1.0).CGColor
                var newColor2 = UIColor.hexColor(0xAAAAAA,alpha: 1.0).CGColor
                var arrayColor : [CGColor] = [newColor1,newColor2]
                gra.colors = arrayColor
                button.layer.insertSublayer(gra, atIndex: 0)
                button.setTitle(title[CountBtn], forState: UIControlState.Normal)
                button.setTitleColor(UIColor.hexColor(0x003300,alpha: 1.0), forState: .Highlighted)
                button.layer.masksToBounds = true
                button.layer.cornerRadius = 5.0
                self.view.addSubview(button)
                button.layer.shadowColor = UIColor.grayColor().CGColor
                // 濃さを指定
                button.layer.shadowOpacity = 5000
                // 影までの距離を指定
                button.layer.shadowOffset = CGSizeMake(10, 10)
                button.addTarget(self, action: "pushBtn:", forControlEvents: .TouchUpInside)
                
            }
        }
    }
    
    func pushBtn(sender: UIButton){
        //editBoxに文字列が入っているか？
        switch(sender.currentTitle!){
        case "1","2","3","4","5","6","7","8","9","0" :
            addText(sender.currentTitle!.toInt()!)
        case "SET" :
            if errChk() {
                var mess :String = game.inpJadge(inpBox)
                status = mess
                if mess == "Complete!" {
                    messBox.text = mess
                    game = HitAndBlow()
                }else{
                    messBox.text = mess
                }
                prvBox.text = "前回の入力:"+toString(inpBox[0])+toString(inpBox[1])+toString(inpBox[2])+toString(inpBox[3])
                limitNum -= 1
            }else{
                messBox.text = ""
                prvBox.text = "4つ数字を入力してね！"
            }
            pushCL()
        case "CL" :
            pushCL()
        default :
            println()

        }
    }
    
    func addText(num:Int){
        var jadge : Bool = false
        
        for i in inpBox {
            if i == num {
                jadge = true
            }
        }
        if jadge {
            messBox.text = "同じ数字は入力できません"
        }else{
            messBox.text = status
            if cursor < 4 {
                inpBox[cursor] = num
                cursor++
            }
        }
        
        displayNum()
    }

    func pushCL(){
        cursor = 0
        inpBox = [-1,-1,-1,-1]
        displayNum()
    }
    
    func errChk()->Bool{
        for i in inpBox {
            if i == -1 {
                return false
            }
        }
        return true
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
