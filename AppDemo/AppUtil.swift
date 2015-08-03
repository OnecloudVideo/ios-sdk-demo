//
//  AppUtil.swift
//  AppDemo
//
//  Created by kinghai on 7/10/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import Foundation
import UIKit

class AppUtil {
    
    static func onFail(code : Int?, msg : String) {
        alert("错误提示", msg: "代码 ： \(code) \n 详情： \(msg)")
    }
    
    static func alert(title : String, msg : String) {
        let alert = UIAlertView()
        
        alert.title = title
        alert.message = msg
        alert.addButtonWithTitle("确定")
        
        alert.show()
    }
    
    static func runOnMainThread(closure : () -> ()) {
        dispatch_async(dispatch_get_main_queue(), closure)
    }
    
    static func stringFromDate(date : NSDate) -> String {
        return getDateFormatter().stringFromDate(date)
    }
    
    static func dateFromString(str : String) -> NSDate? {
        return getDateFormatter().dateFromString(str)
    }
    
    static func getDateFormatter() -> NSDateFormatter {
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        return dateFormatter
    }
    
    private static func sizeSmallerThan(size : Int, bytes : Int) -> Bool {
        return 0 == size / bytes
    }
    
    static func stringFromSize(size : UInt) -> String {
        
        let sizeInt = Int(size)
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        if sizeSmallerThan(sizeInt, bytes: 1024) {
            return "\(size % 1024)B"
        }
        
        if sizeSmallerThan(sizeInt, bytes: 1024 * 1024) {
            return "\(formatter.stringFromNumber(Double(size) / 1024.0)!)KB"
        }
        
        if sizeSmallerThan(sizeInt, bytes: 1024 * 1024 * 1024) {
            return "\(formatter.stringFromNumber(Double(size) / 1024.0 / 1024.0)!)MB"
        }
        
        if sizeSmallerThan(sizeInt, bytes: 1024 * 1024 * 1024 * 1024) {
            return "\(formatter.stringFromNumber(Double(size) / 1024.0 / 1024.0 / 1024)!)GB"
        }
        
        return "\(formatter.stringFromNumber(Double(size) / 1024.0 / 1024.0 / 1024 / 1024)!)TB"
    }
}