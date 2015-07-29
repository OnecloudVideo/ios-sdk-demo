//
//  SDKUsageTest.swift
//  SDKDemo
//
//  Created by kinghai on 7/3/15.
//  Copyright (c) 2015 ftguang. All rights reserved.
//

import UIKit
import XCTest
import AppDemo

class SDKUsageTest: XCTestCase {

    var usageService : UsageService?
    
    var now, startAt, endAt : NSDate?
    
    override func setUp() {
        super.setUp()
        
        usageService = getSDK().getUsageService()
        
        now = NSDate()
        startAt = NSDate(timeInterval: -100 * 24 * 60 * 60, sinceDate: now!)
        endAt = now
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func onFail(code : Int?, msg : String) -> Void {
        println("code is \(code), msg is \(msg)")
        XCTFail("fail")
    }

    func testIps() {
        usageService?.ip({ (usages) -> Void in
            XCTAssertNotNil(usages, " ")
        }, onFail: onFail, field: .Day, startAt: startAt!, endAt: endAt!)
    }

    func testStorage() {
        usageService?.storage({ (usages) -> Void in
            XCTAssertNotNil(usages, " ")
            }, onFail: onFail, field: .Day, startAt: startAt!, endAt: endAt!)
    }
    
    func testBandwidth() {
        usageService?.bandwidth({ (usages) -> Void in
            XCTAssertNotNil(usages, " ")
            }, onFail: onFail, field: .Day, startAt: startAt!, endAt: endAt!)
    }
    
    func testVideoAdded() {
        usageService?.videoAdded({ (usages) -> Void in
            XCTAssertNotNil(usages, " ")
            }, onFail: onFail, field: .Day, startAt: startAt!, endAt: endAt!)
    }
    
    func testVideoTotal() {
        usageService?.videoTotal({ (usages) -> Void in
            XCTAssertNotNil(usages, " ")
            }, onFail: onFail, field: .Day, startAt: startAt!, endAt: endAt!)
    }
    
    
    func testplayTimes() {
        usageService?.playTimes({ (usages) -> Void in
            XCTAssertNotNil(usages, " ")
            }, onFail: onFail, field: .Day, startAt: startAt!, endAt: endAt!)
    }
}
