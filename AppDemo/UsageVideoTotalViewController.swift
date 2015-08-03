//
//  UsageVideoTotalViewController.swift
//  AppDemo
//
//  Created by kinghai on 7/30/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit

class UsageVideoTotalViewController: UsageBaseViewController {
    
    @IBOutlet weak var startTimeBtn: UIButton!
    @IBOutlet weak var endTimeBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func getTableViewCellIdentifier() -> String {
        return "usageVideoTotalCellIdentifier"
    }
    
    override func getTableViewHeaderCellIdentifier() -> String {
        return "usageVideoTotalHeaderCellIdentifier"
    }
    
    override func getStartTimeBtn() -> UIButton {
        return startTimeBtn
    }
    
    override func getEndTimeBtn() -> UIButton {
        return endTimeBtn
    }
    
    override func getTableView() -> UITableView {
        return tableView
    }
    
    override func updateTableView(startTime: NSDate, endTime: NSDate) {
        AppContext.sdk?.getUsageService().videoTotal({ (usages) -> Void in
            self.usages = usages
            }, onFail: AppUtil.onFail, field: .Day, startAt: startTime, endAt: endTime)
    }
    
    @IBAction func startTimeBtnClick(sender: UIButton) {
        updateStartTime()
    }
    
    @IBAction func onEndTimeBtnClick(sender: UIButton) {
        updateEndTime()
    }
}
