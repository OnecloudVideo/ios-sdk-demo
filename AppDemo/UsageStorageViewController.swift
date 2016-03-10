//
//  UsageStorageViewController.swift
//  AppDemo
//
//  Created by kinghai on 7/30/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit

class UsageStorageViewController: UsageBaseViewController {
    
    @IBOutlet weak var startTimeBtn: UIButton!
    @IBOutlet weak var endTimeBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func getTableViewHeaderCellIdentifier() -> String {
        return "usageStorageHeaderCellIdentifier"
    }
    
    override func getTableViewCellIdentifier() -> String {
        return "usageStorageCellIdentifier"
    }
    
    override func updateTableView(startTime: NSDate, endTime: NSDate) {
        AppContext.sdk?.getUsageService().storage({ (usages) -> Void in
            self.usages = usages
            }, onFail: AppUtil.createOnFail(self), field: .Day, startAt: startTime, endAt: endTime)
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
    
    @IBAction func startTimeBtnClick(sender: UIButton) {
        updateStartTime()
    }
    
    @IBAction func onEndTimeBtnClick(sender: UIButton) {
        updateEndTime()
    }
}
