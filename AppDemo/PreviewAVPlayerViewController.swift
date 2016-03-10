//
//  PreviewAVPlayerViewController.swift
//  AppDemo
//
//  Created by kinghai on 7/10/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import VideoSDK

class PreviewAVPlayerViewController: AVPlayerViewController {
    
    var videoService : VideoService?
    var video : Video?
    {
        didSet {

            if let tvs = video?.transcodedVideos {
                if let m3u8 = tvs[0].m3u8 {
                    
                    print(" m3u8 is \(m3u8)")
                    
                    let steamingURL:NSURL = NSURL(string: m3u8)!
                    player = AVPlayer(URL: steamingURL)
                    player!.play()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("preview video \(video)")
        
        videoService = AppContext.sdk?.getVideoService()
        
        load()
    }
    
    func load() {
     
        videoService?.get({ (video) -> Void in
            self.video  = video
            
        }, onFail: AppUtil.createOnFail(self), id: video!.id!)
    }
}
