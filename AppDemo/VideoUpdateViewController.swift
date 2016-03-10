//
//  VideoUpdateViewController.swift
//  AppDemo
//
//  Created by kinghai on 7/16/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit
import VideoSDK

class VideoUpdateViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descTextArea: UITextView!
    
    var video : Video?
    {
        didSet {
            
        }
    }
    
    @IBAction func onSaveBtnClick(sender: UIButton) {
        print("click update video save btn")
        
        let updatedName = nameTextField.text
        let updatedDesc = descTextArea.text
        
        AppContext.sdk?.getVideoService().update({ (msg) -> Void in
           
            self.video?.name = updatedName
            self.video?.description = updatedDesc
            
            AppUtil.createAlert(self)(title: "编辑成功", msg: "")
            
            self.back()
            
        }, onFail: AppUtil.createOnFail(self), id: video!.id!, name: updatedName!, description: updatedDesc)

    }
    
    @IBAction func nameTextDidEndOnExit(sender: UITextField) {
        
        descTextArea.becomeFirstResponder()
        
    }
    
    @IBAction func onCancelBtnClick(sender: UIButton) {
        print("click update video cancel btn")
        back()
        
    }
    
    func back() {
//        parentViewController?.navigationController?.popViewControllerAnimated(true)
        navigationController?.popViewControllerAnimated(true)
        
        print("call popview")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameTextField.becomeFirstResponder()
        nameTextField.delegate = self
        
        descTextArea.layer.borderColor = UIColor.grayColor().CGColor
        descTextArea.layer.borderWidth = 1
        descTextArea.layer.cornerRadius = 0.5
        
        AppContext.sdk?.getVideoService().get({ (v) -> Void in
            self.nameTextField.text =  NSURL(fileURLWithPath: v.name!).URLByDeletingPathExtension?.lastPathComponent
            self.descTextArea.text = v.description
            
            self.video?.name = v.name
            self.video?.description = v.description
            
        }, onFail: AppUtil.createOnFail(self), id: video!.id!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backgroundTouchDown(sender: AnyObject) {
        self.view.endEditing(true)
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
