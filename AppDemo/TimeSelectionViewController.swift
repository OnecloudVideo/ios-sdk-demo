//
//  TimeSelectionViewController.swift
//  AppDemo
//
//  Created by kinghai on 7/29/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit

class TimeSelectionViewController: UIViewController {

    var date : NSDate? {
        didSet {
            println("date has been change")
        }
    }
    
    var callback : ((date : NSDate) -> Void)?
    
    @IBOutlet weak var datePicker: UIDatePicker!
  
    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker.datePickerMode = .Date
        datePicker.date = date!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    @IBAction func onValueChanged(sender: UIDatePicker) {
        println("select \(sender.date)")
        
        date?.timeIntervalSinceDate(sender.date)
        
        println("\(date == sender.date)")
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let cb = callback {
            cb(date: datePicker.date)
        }
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
