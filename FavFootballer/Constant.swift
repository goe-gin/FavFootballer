//
//  Const.swift
//  FavFootballer
//
//  Created by Tomoaki Tashiro on 2019/11/10.
//  Copyright © 2019 Tomoaki Tashiro. All rights reserved.
//

import Foundation
import UIKit

struct Constant {
    
    // デフォルトの範囲指定対象
    static let defaultRangeStatus = "overall_rating"
    
    // デフォルトの範囲指定最大値
    static let defaultRangeMax = 99
    
    // デフォルトの範囲指定最小値
    static let defaultRangeMin = 0
    
    // バージョン
    static let versionList = ["players_default", "players_latest"]
    
    // 範囲指定対象
    static let rangeList = ["Overall Rating",  "Potential"]
    
    // ポジション
    static let positionList = ["", "ST", "CF", "LF", "RF", "LW", "RW", "CAM", "LM", "RM", "CM", "CDM", "LWB", "RWB", "LB", "RB", "CB", "GK"]
    
    // 利き足
    static let preferredFootList = ["", "Right", "Left"]
    
    // スキルムーブ、逆足精度
    static let skillList = ["", "1", "2", "3", "4", "5"]
    
    // 固有フェイス
    static let realFaceList = ["", "Yes", "No"]
    
    // 攻撃、守備意識
    static let workRateList = ["", "High", "Medium", "Low"]
    
    // ステータスの選択範囲を返す
    static func setStatusRange() -> [String] {
        
        let rangeIntArray = [Int](0...99)
        var rangeStringArray: [String]
        
        rangeStringArray = rangeIntArray.map({ (value: Int) -> String in
            return String(value)
        })
        return rangeStringArray
    }
    
    // 年齢の選択範囲を返す
    static func setAgeRange() -> [String] {
        
        let rangeIntArray = [Int](16...50)
        var rangeStringArray: [String]
        
        rangeStringArray = rangeIntArray.map({ (value: Int) -> String in
            return String(value)
        })
        rangeStringArray.insert("", at: 0)
        
        return rangeStringArray
    }
    
    // ラベルの背景カラーを返す
    static func setLabelColor(label: UILabel) -> UIColor {
        
        var color = UIColor()
        
        switch Int(label.text!)! {
            
        case 70..<80:
            color = UIColor(red: 170/255, green: 205/255, blue: 50/255, alpha: 1.0)
        case 60..<70:
            color = UIColor(red: 255/255, green: 205/255, blue: 25/255, alpha: 1.0)
        case 50..<60:
            color = UIColor(red: 240/255, green: 140/255, blue: 0, alpha: 1.0)
        case 1..<50:
            color = UIColor(red: 180/255, green: 30/255, blue: 30/255, alpha: 1.0)
        default:
            color = UIColor(red: 45/255, green: 150/255, blue: 0, alpha: 1.0)
        }
        return color
    }
}

