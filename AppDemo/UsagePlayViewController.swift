//
//  UsagePlayViewController.swift
//  AppDemo
//
//  Created by kinghai on 7/29/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit

class UsagePlayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var startTimeBtn: UIButton!
    @IBOutlet weak var endTimeBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!

    var usages = [Usage<UInt>]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    var startTime : NSDate?
    {
        didSet {
            if startTime?.timeIntervalSinceNow > endTime?.timeIntervalSinceNow {
                
                AppUtil.alert("", msg: "不允许开始时间晚于结束时间")
                startTime = oldValue
            }
            
            if let st = startTime {
                startTimeBtn.setTitle(AppUtil.stringFromDate(st), forState: .Normal)
            }
        }
    }
    var endTime : NSDate?
        {
        didSet {
            
            if startTime?.timeIntervalSinceNow > endTime?.timeIntervalSinceNow {
                AppUtil.alert("", msg: "不允许开始时间晚于结束时间")
                endTime = oldValue
            }
            
            if let et = endTime {
               endTimeBtn.setTitle(AppUtil.stringFromDate(et), forState: .Normal)
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        endTime = NSDate()
        startTime = NSDate(timeInterval: -24 * 60 * 60, sinceDate: endTime!)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        updateTableView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startTimeBtnClick(sender: UIButton) {
//        performSegueWithIdentifier("usagePlayStartTimeSelectionSegue", sender: self)
        let board = UIStoryboard()
        let controller = board.instantiateViewControllerWithIdentifier("TimeSelectorViewController") as! UIViewController
        
        presentViewController(controller, animated: true, completion: nil)
        
    }

    @IBAction func onEndTimeBtnClick(sender: UIButton) {
        performSegueWithIdentifier("usagePlayEndTimeSelectionSegue", sender: self)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        switch segue.identifier! {
        case "usagePlayStartTimeSelectionSegue" :
            let timeController =
            (segue.destinationViewController as! TimeSelectionViewController)
            
            timeController.date = startTime
            timeController.callback = {(date : NSDate) in
                self.startTime = date
                self.updateTableView()
            }
        case "usagePlayEndTimeSelectionSegue" :
            let timeController =
            (segue.destinationViewController as! TimeSelectionViewController)
            
            timeController.date = endTime
            timeController.callback = {(date : NSDate) in
                self.endTime = date
                self.updateTableView()
            }
        default:
            println("other segue")
        }
    }
    
    func updateTableView() {
        AppContext.sdk?.getUsageService().playTimes({ (usages) -> Void in
            self.usages = usages
        }, onFail: AppUtil.onFail, field: .Day, startAt: startTime!, endAt: endTime!)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usages.count
    }

    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableCellWithIdentifier("usagePlayHeaderCellIdentifier") as? UIView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : UsagePlayViewCell = tableView.dequeueReusableCellWithIdentifier("usagePlayCellIdentifier", forIndexPath: indexPath) as! UsagePlayViewCell
        
        cell.usage = usages[indexPath.row]
        return cell
    }
}
