//
//  LoginViewController.swift
//  AppDemo
//
//  Created by kinghai on 7/8/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit


class LoginViewController : UIViewController {
    
    @IBOutlet weak var accessSecretField: UITextField!
    @IBOutlet weak var accessKeyField: UITextField!
    @IBOutlet weak var warnMsg: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        warnMsg.textColor = UIColor.redColor()
        warnMsg.text = ""
    }
    
    @IBAction func loginClick(sender: UIButton) {
        
        let ovp = "http://video.pispower.com/"
        let accessKey = accessKeyField.text
        let accessSecret = accessSecretField.text
        
        valid(ovp, accessKey: accessKey, accessSecret: accessSecret) { (sdk : VideoSDK) in
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
}