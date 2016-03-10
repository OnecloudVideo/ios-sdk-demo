//
//  UsageBandwidthViewCell.swift
//  AppDemo
//
//  Created by kinghai on 7/30/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit
import VideoSDK

class UsageBandwidthViewCell: UsageBaseViewCell {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var bandwidthLbl: UILabel!
    
    override func updateUsage(usage: Usage<UInt>) {
        
        timeLbl.text = AppUtil.stringFromDate(usage.startAt)
        bandwidthLbl.text = "\(AppUtil.stringFromSize(usage.usage))"
    }
}
