//
//  UsagePlayViewCell.swift
//  AppDemo
//
//  Created by kinghai on 7/29/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit

class UsagePlayViewCell: UITableViewCell {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var playTimesLbl: UILabel!
    
    var usage : Usage<UInt>? {
        didSet {
            if let u = usage {
                timeLbl.text = AppUtil.stringFromDate(u.startAt)
                playTimesLbl.text = "\(u.usage)"
            }
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

}
