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
    
//    static func onFail(code : Int?, msg : String) {
//        alert("错误提示", msg: "代码 ： \(code) \n 详情： \(msg)")
//    }
//    
//    static func alert(title : String, msg : String) {
//        let alert = UIAlertView()
//        
//        alert.title = title
//        alert.message = msg
//        alert.addButtonWithTitle("确定")
//        
//        alert.show()
//    }
    
    //ios 9.0 later
    static func createOnFail(parent: UIViewController) -> (code : Int?, msg : String) -> Void {
        return { (code : Int?, msg : String) in
            createAlert(parent)(title: "错误提示", msg: "代码 ： \(code) \n 详情： \(msg)")
        }
    }
    
    //ios 9.0 later
    static func createAlert(parent: UIViewController) -> (title: String, msg: String) -> Void {
        
        func alert(title: String, msg: String) {
            
            let alertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
            
            let okAction = UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(okAction)
            
            parent.presentViewController(alertController, animated: false){}
            NSLog("popup alert window \(alertController)")
        }
        
        return alert
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
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        return dateFormatter
    }
    
    private static func sizeSmallerThan(size : Int64, bytes : Int64) -> Bool {
        
        return 0 == size / bytes
    }
    
    static func stringFromSize(size : UInt) -> String {
        
        let sizeInt = Int(size)
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        if sizeSmallerThan(Int64(sizeInt), bytes: 1024) {
            return "\(size % 1024)B"
        }
        
        if sizeSmallerThan(Int64(sizeInt), bytes: 1024 * 1024) {
            return "\(formatter.stringFromNumber(Double(size) / 1024.0)!)KB"
        }
        
        if sizeSmallerThan(Int64(sizeInt), bytes: 1024 * 1024 * 1024) {
            return "\(formatter.stringFromNumber(Double(size) / 1024.0 / 1024.0)!)MB"
        }
        
        if sizeSmallerThan(Int64(sizeInt), bytes: 1024 * 1024 * 1024 * 1024) {
            return "\(formatter.stringFromNumber(Double(size) / 1024.0 / 1024.0 / 1024)!)GB"
        }
        
        return "\(formatter.stringFromNumber(Double(size) / 1024.0 / 1024.0 / 1024 / 1024)!)TB"
    }
}