//
//  UsagePlayViewCell.swift
//  AppDemo
//
//  Created by kinghai on 7/29/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit
import VideoSDK

class UsagePlayViewCell: UsageBaseViewCell {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var playTimesLbl: UILabel!
    
    override func updateUsage(usage: Usage<UInt>) {
        timeLbl.text = AppUtil.stringFromDate(usage.startAt)
        playTimesLbl.text = "\(usage.usage)"
    }
}