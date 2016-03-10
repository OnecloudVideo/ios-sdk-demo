//
//  LoginViewController.swift
//  AppDemo
//
//  Created by kinghai on 7/8/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit
import VideoSDK

class LoginViewController : UIViewController {
    
    @IBOutlet weak var accessSecretField: UITextField!
    @IBOutlet weak var accessKeyField: UITextField!
    @IBOutlet weak var warnMsg: UILabel!
    var textFieldFlowup = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        warnMsg.textColor = UIColor.redColor()
        warnMsg.text = ""
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    @IBAction func loginClick(sender: UIButton) {
        
        let ovp = "http://video.cloudak47.com/"
        let accessKey = accessKeyField.text
        let accessSecret = accessSecretField.text
        
        valid(ovp, accessKey: accessKey!, accessSecret: accessSecret!) { (sdk : VideoSDK) in
            AppContext.sdk = sdk
            self.toMainCavas()
        }
    }
    
    func valid(ovp : String, accessKey : String, accessSecret : String, onSuccess : (sdk : VideoSDK) -> Void) {
        
        let sdk = VideoSDK(host: ovp, accessKey: accessKey, accessSecret: accessSecret)
        
        //valid accesskey and secret field
        sdk.getCatalogService().list({ (catalogs) -> Void in
            onSuccess(sdk: sdk)
        }, onFail: onFail)
    }
    
    func toMainCavas() {
        self.performSegueWithIdentifier("loginSegue", sender: self)
    }
    
    func onFail(code : Int?, msg : String) {
        warnMsg.text = "error occur for \(msg)"
    }
    
    @IBAction func onViewTouchDown(sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            
            if (textFieldFlowup) {
                return
            }
            
            self.view.frame.origin.y -= keyboardSize.height
            textFieldFlowup = true
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.CGRectValue() {
            
            if (!textFieldFlowup) {
                return
            }
            
            self.view.frame.origin.y += keyboardSize.height
            textFieldFlowup = false
        }
    }
}