//
//  UsageBaseViewCell.swift
//  AppDemo
//
//  Created by kinghai on 7/31/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit

class UsageBaseViewCell: UITableViewCell {

    var usage : Usage<UInt>? {
        didSet {
            if let u = usage {
                updateUsage(u)
            }
        }
    }

    func updateUsage(usage : Usage<UInt>) {
        preconditionFailure("This method must be override")
    }
}
