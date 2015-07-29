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
        println("click login btn")
        valid()
    }
    
    func valid() {
        
        let ovp = "http://video.pispower.com/"
        let accessKey = accessKeyField.text
        let accessSecret = accessSecretField.text
        
        let sdk = VideoSDK(host: ovp, accessKey: accessKey, accessSecret: accessSecret)
        
    
        
        //valid accesskey and secret is ok
        //for
        sdk.getCatalogService().list({ (catalogs) -> Void in
            
            AppContext.sdk = sdk
            
            //go to main cavas
            self.toMainCavas()
        }, onFail: onFail)
    }
    
    func toMainCavas() {
        println("Go to Main Cavas")
  
        self.performSegueWithIdentifier("loginSegue", sender: self)
    }
    
    func onFail(code : Int?, msg : String) {
        println("login fail for \(msg)")
        
        warnMsg.text = "error occur for \(msg)"
    }
}


