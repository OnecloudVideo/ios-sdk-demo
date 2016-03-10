//
//  UsageIPTViewCell.swift
//  AppDemo
//
//  Created by kinghai on 7/29/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit
import VideoSDK

class UsageIPViewCell: UsageBaseViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var ipLbl: UILabel!
   
    override func updateUsage(usage: Usage<UInt>) {
        dateLbl.text = AppUtil.stringFromDate(usage.startAt)
        ipLbl.text = "\(usage.usage)"
    }
}