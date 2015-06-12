//
//  HitAndBlow.swift
//  HitAndBlow
//
//  Created by hirosawak on 2015/06/11.
//  Copyright (c) 2015年 hirosawak. All rights reserved.
//

import Foundation

class HitAndBlow {
    
    //ランダムに配列を作る
    var setNumList : [Int] = [0,1,2,3,4,5,6,7,8,9]
    var randNumList : [Int] = []
    
    //初期化
    init(){
        randNum()
    }

    //ランダムな数の答えを作成
    func randNum(){
        for i in 0..<4 {
            var randInt : Int = Int(arc4random_uniform(UInt32(setNumList.count)));
            randNumList.append(setNumList[randInt])
            setNumList.removeAtIndex(randInt)
        }
    }
    
    //入力された値に対してHIT,BLOWを返す
    func inpJadge(InpNumList:[Int])->String{
        //判定
        var hit : Int = 0
        var blow : Int = 0
        
        for i in 0..<InpNumList.count {
            if(randNumList[i] == InpNumList[i]){
                //行番が同じで中身も同じならHIT
                hit++
            }
            for j in 0..<randNumList.count {
                if i == j {
                    //行番が同じならスキップ
                    continue
                } else {
                    if randNumList[j] == InpNumList[i] {
                        //中身が同じならBLOW
                        blow++
                    }
                }
            }
        }
        
        //結果
        if hit == 4 {
            return "Complete!"
        } else {
            return "\(hit)HIT!\(blow)BLOW!"
        }
    }
}