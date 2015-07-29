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

class PreviewAVPlayerViewController: AVPlayerViewController {
    
    var videoService : VideoService?
    var video : Video?
    {
        didSet {

            if let tvs = video?.transcodedVideos {
                if let m3u8 = tvs[0].m3u8 {
                    
                    println(" m3u8 is \(m3u8)")
                    
                    var steamingURL:NSURL = NSURL(string: m3u8)!
                    player = AVPlayer(URL: steamingURL)
                    player.play()
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        println("preview video \(video)")
        
        videoService = AppContext.sdk?.getVideoService()
        
        load()
    }
    
    func load() {
     
        videoService?.get({ (video) -> Void in
            self.video  = video
            
        }, onFail: AppUtil.onFail, id: video!.id!)
    }
}
