//
//  UsageBaseViewController.swift
//  AppDemo
//
//  Created by kinghai on 7/31/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit
import VideoSDK

class UsageBaseViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {

    var usages = [Usage<UInt>]() {
        didSet {
           getTableView().reloadData()
        }
    }
    
    var startTime : NSDate?
        {
        didSet {
            if startTime == oldValue {
                return
            }
            
            if startTime?.timeIntervalSinceNow > endTime?.timeIntervalSinceNow {
                AppUtil.createAlert(self)(title: "", msg: "不允许开始时间晚于结束时间")
                startTime = oldValue
                return
            }
            
            if let st = startTime {
                getStartTimeBtn().setTitle(AppUtil.stringFromDate(st), forState: .Normal)
            }
            
            updateTableView()
        }
    }
    var endTime : NSDate?
        {
        didSet {
            
            if endTime == oldValue {
                return
            }
            
            if startTime?.timeIntervalSinceNow > endTime?.timeIntervalSinceNow {
                AppUtil.createAlert(self)(title: "", msg: "不允许开始时间晚于结束时间")
                endTime = oldValue
                return
            }
            
            if let et = endTime {
                getEndTimeBtn().setTitle(AppUtil.stringFromDate(et), forState: .Normal)
            }
            
            updateTableView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getTableView().delegate = self
        getTableView().dataSource = self
        
        endTime = NSDate()
        startTime = NSDate(timeInterval: -24 * 60 * 60 * 30, sinceDate: endTime!)
    }
    
    func updateStartTime() {
        DatePickerViewController.show(self, date: startTime!, onchange: nil) { (newDate) -> Void in
            self.startTime = newDate
        }
    }
    
    func updateEndTime() {
        DatePickerViewController.show(self, date: endTime!, onchange: nil) { (newDate) -> Void in
            self.endTime = newDate
        }
    }
    
    func getStartTimeBtn() -> UIButton {
        preconditionFailure("This method must be override")
    }
    
    func getEndTimeBtn() -> UIButton {
        preconditionFailure("This method must be override")
    }
    
    func getTableView() -> UITableView {
        preconditionFailure("This method must be override")
    }
    
    func getTableViewHeaderCellIdentifier() -> String {
        preconditionFailure("This method must be override")
    }
    
    func getTableViewCellIdentifier() -> String {
        preconditionFailure("This method must be override")
    }
    
    func updateTableView(startTime : NSDate, endTime : NSDate) {
        preconditionFailure("This method must be override")
    }
    
    func updateTableView() {
        if nil == startTime || nil == endTime {
            return
        }
        
        updateTableView(self.startTime!, endTime: self.endTime!)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usages.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableCellWithIdentifier(getTableViewHeaderCellIdentifier()) as? UIView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UsageBaseViewCell = tableView.dequeueReusableCellWithIdentifier(getTableViewCellIdentifier(), forIndexPath: indexPath) as! UsageBaseViewCell
        
        cell.usage = usages[indexPath.row]
        return cell
    }
}
