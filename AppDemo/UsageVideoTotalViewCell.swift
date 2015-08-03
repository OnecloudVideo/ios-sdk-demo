//
//  UsageVideoTotalViewCell.swift
//  AppDemo
//
//  Created by kinghai on 7/30/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit

class UsageVideoTotalViewCell: UsageBaseViewCell {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!

    override func updateUsage(usage: Usage<UInt>) {
        timeLbl.text = AppUtil.stringFromDate(usage.startAt)
        totalLbl.text = "\(usage.usage)"
    }
}
