//
//  UsageVideoAddedViewCell.swift
//  AppDemo
//
//  Created by kinghai on 7/30/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit
import VideoSDK

class UsageVideoAddedViewCell: UsageBaseViewCell {
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var addedLbl: UILabel!
    
    override func updateUsage(usage: Usage<UInt>) {
        timeLbl.text = AppUtil.stringFromDate(usage.startAt)
        addedLbl.text = "\(usage.usage)"

    }
}