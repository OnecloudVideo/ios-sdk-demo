//
//  VideoUpdateViewController.swift
//  AppDemo
//
//  Created by kinghai on 7/16/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit

class VideoUpdateViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descTextArea: UITextView!
    
    var video : Video?
    {
        didSet {
            
        }
    }
    
    @IBAction func onSaveBtnClick(sender: UIButton) {
        println("click update video save btn")
        
        let updatedName = nameTextField.text
        let updatedDesc = descTextArea.text
        
        AppContext.sdk?.getVideoService().update({ (msg) -> Void in
           
            self.video?.name = updatedName
            self.video?.description = updatedDesc
            
            AppUtil.alert("编辑成功", msg: "")
            
            self.back()
            
        }, onFail: AppUtil.onFail, id: video!.id!, name: updatedName, description: updatedDesc)

    }
    
    
    @IBAction func onCancelBtnClick(sender: UIButton) {
        println("click update video cancel btn")
        back()
        
    }
    
    func back() {
        parentViewController?.navigationController?.popViewControllerAnimated(true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.becomeFirstResponder()
        nameTextField.delegate = self
        
        descTextArea.layer.borderColor = UIColor.grayColor().CGColor
        descTextArea.layer.borderWidth = 1
        descTextArea.layer.cornerRadius = 0.5
        
        AppContext.sdk?.getVideoService().get({ (v) -> Void in
            
            
            
            self.nameTextField.text = v.name!.stringByDeletingPathExtension
            self.descTextArea.text = v.description
            
            self.video?.name = v.name
            self.video?.description = v.description
            
        }, onFail: AppUtil.onFail, id: video!.id!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
