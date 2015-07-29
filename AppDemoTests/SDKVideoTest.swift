//
//  SDKVideoTest.swift
//  SDKDemo
//
//  Created by kinghai on 7/3/15.
//  Copyright (c) 2015 ftguang. All rights reserved.
//

import UIKit
import XCTest
import AppDemo

class SDKVideoTest: XCTestCase {

    var videoService : VideoService?
    
    var CATALOG_ID = "196"
    let VIDEO_ID = "932"
    let VIDEO = "/Users/kinghai/Documents/workspace/html5-portable-player/WebContent/trailer.mp4"
    
    let DELETE_VIDEO_ID = "930"
    
    override func setUp() {
        super.setUp()
        
        videoService = getSDK().getVideoService()
    }
    
    func onFail(code : Int?, msg : String) -> Void {
        println("code is \(code), msg is \(msg)")
        XCTFail("fail")
    }
    
    func testList() {
        videoService?.list({ (videos) -> Void in
            XCTAssertNotNil(videos, " ")
        }, onFail: onFail, catalogId: CATALOG_ID)
    }

    func testGet() {
        videoService?.get({ (video) -> Void in
            XCTAssertNotNil(video, " ")
        }, onFail: onFail, id: VIDEO_ID)
    }
    
    func testUpload() {
        videoService?.upload({ (video) -> Void in
            XCTAssertNotNil(video, " ")
        }, onFail: onFail, filePath: VIDEO, catalogId: CATALOG_ID, name: "swiftTestUploadVideo", description: "i am a test video")
    }
    
    func testDelete() {
        videoService?.delete({ (msg) -> Void in
            XCTAssertNotNil(msg, " ")
        }, onFail: onFail, id: "932")
    }
    
    func testUpdate() {
        videoService?.update({ (msg) -> Void in
            XCTAssertNotNil(msg, " ")
        }, onFail: onFail, id: VIDEO_ID, name: "Wildlife", description: "swiftTest_11")
    }
}
