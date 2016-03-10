//
//  VideoTableViewCell.swift
//  AppDemo
//
//  Created by kinghai on 7/10/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit
import VideoSDK

class VideoTableViewCell: UITableViewCell, PropertyChangeDelegate {

    @IBOutlet weak var poster: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var size: UILabel!
    
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var uploadProgress: UIProgressView!
    
    @IBOutlet weak var uploadLabel: UILabel!
    
    @IBOutlet weak var resumeBtn: UIButton!
    
    weak var controller : VideoTableViewController?
    
    var video : Video? {
        didSet {
            
            if let v = video {
                
                v.propertyChangeDelegate = self
            }
            
            resumeBtn.hidden = true
            uploadLabel.hidden = true
            uploadProgress.hidden = true
            uploadProgress.hidden = true
            
            update()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func onResume(sender: UIButton) {
        resumeBtn.hidden = true
        
        AppUtil.runOnMainThread { () -> () in
            AppContext.sdk?.getMultipartService().upload({ (video) -> Void in
                
                }, onFail: AppUtil.createOnFail(self.controller!), multipartVideo: self.video as! MultipartVideo)
        }
    }
    
    func onChange(property : String, newValue : Any?, oldValue : Any?) {
        
        if "uploadProgress" == property {
            if let v = video {
                AppUtil.runOnMainThread({ () -> () in
                    self.uploadProgress.progress = Float(v.uploadProgress)
                    self.uploadLabel.text = "\(Int(Float(v.uploadProgress) * 100))%"
                })
            }
            
        } else if "status" == property {
            update()
            
            AppUtil.runOnMainThread({ () -> () in
                self.controller?.tableView.reloadData()
            })
            
        } else {
            update()
        }
    }
    
    func update() {
        if let v = video {
            AppUtil.runOnMainThread({ () -> () in
                self.name.text = v.name!
                //        cell.size.text = v.si
                
                if v.isVideo() {
                    self.poster.image = UIImage(named: "video")
                    
                } else if v.isAudio() {
                    self.poster.image = UIImage(named: "audio")
                } else {
                    self.poster.image = UIImage(named: "video")
                }
                
                print(v.size)
                self.size.text = "\(v.size!)"
                
                self.status.text = v.status
                
                if v.isUploading() {
                    let progress = Float(v.uploadProgress)
                    self.uploadProgress.hidden = false
                    self.uploadProgress.progress = progress
                    self.uploadLabel.hidden = false
                    self.uploadLabel.text = "\(Int(progress * 100))%"
                    
                    self.size.hidden = true
                    self.status.hidden = true
                } else {
                    self.uploadProgress.hidden = true
                    self.uploadLabel.hidden = true
                    self.size.hidden = false
                    self.status.hidden = false
                }
                
                if let mv = v as? MultipartVideo {
                    self.resumeBtn.hidden = !mv.halt
                    
                } else {
                    self.resumeBtn.hidden = true
                }
            })
        }
    }
}