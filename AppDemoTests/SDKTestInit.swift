//
//  SDKTestInit.swift
//  SDKDemo
//
//  Created by kinghai on 7/3/15.
//  Copyright (c) 2015 ftguang. All rights reserved.
//

import Foundation
import AppDemo


//big env
let OVP_HOME : String = "http://video.pispower.com/"
let ACCESS_KEY : String = "lrcxgqhyl96psm"
let ACCESS_SERCURIT : String = "62e3ac0f3d6bf07fe36392ad68800fdb"


//small env
//        let OVP_HOME : String = "http://video.onecloud.cn"
//        let ACCESS_KEY : String = "r556qwhy9sddm8"
//        let ACCESS_SERCURIT : String = "4353a89b3b6f4d56e3adf6e6ecac1672"


public func getSDK() -> VideoSDK {
    return VideoSDK(host: OVP_HOME, accessKey: ACCESS_KEY, accessSecret: ACCESS_SERCURIT)
}