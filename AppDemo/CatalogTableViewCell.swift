//
//  CatalogTableViewCell.swift
//  AppDemo
//
//  Created by kinghai on 7/9/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit
import VideoSDK

class CatalogTableViewCell: UITableViewCell, PropertyChangeDelegate {


    @IBOutlet weak var catalogName: UILabel!
    @IBOutlet weak var videoNumber: UILabel!
    
    var catalog : Catalog?
    {
        didSet {
            catalog?.propertyChangeDelegate = self
            updateFace()
        }
    }
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func onChange(property: String, newValue: Any?, oldValue: Any?) {
        updateFace()
    }
    
    func updateFace() {
        catalogName.text = catalog!.name!
        
        if let number = catalog?.videoNumber {
            videoNumber.text = "\(number)"
        } else {
            videoNumber.text = "0"
        }

    }
}
