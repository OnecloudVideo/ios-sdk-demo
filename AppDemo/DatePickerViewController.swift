//
//  DatePickerViewController.swift
//  AppDemo
//
//  Created by kinghai on 7/30/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit

class DatePickerViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
   
    var date : NSDate?
    var parentTitle : String?
    var callback : ((newDate : NSDate) -> Void)?
    var onchange : ((selectDate : NSDate) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        println(self.parentViewController)
        println(self.parentViewController?.parentViewController)
       
        // Do any additional setup after loading the view.
        self.navigationItem.leftBarButtonItems = [ UIBarButtonItem(image: UIImage(named: "arrow_right"), style: UIBarButtonItemStyle.Plain, target: self, action: "backTo:")
        ]
        
        datePicker.datePickerMode = UIDatePickerMode.Date
        datePicker.locale = NSLocale(localeIdentifier: "zh_CN")
        datePicker.addTarget(self, action: Selector("valueChange:"), forControlEvents: UIControlEvents.ValueChanged)
        datePicker.date = date!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func backTo(barBtn : UIBarButtonItem) {
        dismissViewControllerAnimated(true) {
            if let cb = self.callback {
                cb(newDate: self.datePicker.date)
            }
        }
    }
    
    @IBAction func onSwitchPickerMode(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0 :
            datePicker.datePickerMode = .Date
        case 1 :
            datePicker.datePickerMode = .DateAndTime
        default :
            break
        }
    }
    
    func valueChange(sender : UIDatePicker) {
        if let oc = onchange {
            oc(selectDate: sender.date)
        }
    }

    static func show(parent : UIViewController, date : NSDate, onchange : ((selectDate : NSDate) -> Void)?, callback : ((newDate : NSDate) -> Void)?) -> DatePickerViewController {
        let widget = UIStoryboard(name: "Widget", bundle: nil)
        
        let viewController = widget.instantiateViewControllerWithIdentifier("DateSelectorViewController") as! DatePickerViewController
        
        viewController.date = date
        viewController.parentTitle = parent.title
        viewController.onchange = onchange
        viewController.callback = callback
        
        let navigator = UINavigationController(rootViewController: viewController)
        parent.presentViewController(navigator, animated: true, completion: nil)
        
        return viewController
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