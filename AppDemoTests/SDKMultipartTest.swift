//
//  OnecloudVideoSDKTest.swift
//  SDKDemo
//
//  Created by kinghai on 7/2/15.
//  Copyright (c) 2015 ftguang. All rights reserved.
//

import UIKit
import XCTest
import AppDemo

class SDKMultipartTest: XCTestCase {

    let VIDEO = "/Users/kinghai/Documents/workspace/html5-portable-player/WebContent/trailer.mp4"
    let UPLOAD_ID = "fe6107b6fbabe043a62be324c6186577"
    let CATALOG_ID = "194"
    
    var uploadId : String?
    var multipartService : MultipartService?
    
    override func setUp() {
        super.setUp()

        multipartService = getSDK().getMultipartService()
    }
    
    override func tearDown() {
        
        if nil != uploadId {
            //clean
            self.multipartService?.abort({ (fileName) -> Void in
                println(fileName)
                }, onFail: { (code, msg) -> Void in
                    println(code)
                }, uploadId: uploadId!)
        }
        
        super.tearDown()
    }
    
    func onFail(code : Int?, msg : String) {
        println("code is \(code), msg is \(msg)")
        XCTFail("handle fail")
    }

    func testInit() {
        multipartService?.initMultipart({ (uploadId) -> Void in
            XCTAssertNotNil(uploadId, "")
            self.uploadId = uploadId
        }, onFail: onFail, fileName: "trailer.mp4", fileMD5: LocalFile(contentsOfFile: VIDEO)!.md5())
    }
    
//    func testUploadPart() {
//        multipartService?.uploadPart({ (partKey, partMD5) -> Void in
//            XCTAssertNotNil(partKey, "")
//            XCTAssertNotNil(partMD5, "")
//        }, onFail: { (code, msg) -> Void in
//            println(code)
//        }, uploadId: UPLOAD_ID, filePath: VIDEO, partNumber: 1)
//    }
    
//    func testComplete() {
//        //create a new upload Id
//        multipartService?.initMultipart({ (uploadId) -> Void in
//           
//            var partKeys = [String]()
//            
//            var uploadPart = { (part : UInt, afterSuccess : () -> Void) -> Void in
//                
//                println(afterSuccess)
//                self.multipartService?.uploadPart({ (partKey, partMD5) -> Void in
//                   
//                    partKeys.append(partKey)
//                    afterSuccess()
////
//                }, onFail: self.onFail, uploadId: uploadId, filePath: self.VIDEO, partNumber: part)
//            }
//            
//            var complete = {() -> Void in
//                multipartService?.complete({ (video : Video, msg : String) -> Void in
//                    println("-------> ")
//                    println(video)
//                }, onFail: onFail, uploadId: uploadId, partNumbers: partKeys, catalogId: CATALOG_ID)
//            }
//          
//            //upload 4 part content
//            uploadPart(1, {() -> Void in
//                uploadPart(2, {() -> Void in
//                    uploadPart(3, {() -> Void in
//                        uploadPart(4, {() -> Void in
//                            println("all part is uploaded success")
//                            
//                            //begin test complete
//                            complete()
//                        })
//                    })
//                })
//            })
//            //call complete
//            
//        }, onFail: onFail, fileName: "trailer.mp4", fileMD5: LocalFile(contentsOfFile: VIDEO)!.md5())
//
//    }
    
        func testAbort() {
            multipartService?.initMultipart({ (uploadId) -> Void in
                self.uploadId = uploadId
                
                var uploadPart = { (part : UInt) -> Void in
                        //test abort
                        multipartService?.abort({ (fileName) -> Void in
                            XCTAssertNotNil(fileName, "")
                            }, onFail: onFail, uploadId: uploadId)
  
                }
            }, onFail: onFail, fileName: "trailer.mp4", fileMD5: LocalFile(contentsOfFile: VIDEO)!.md5())
        }
    
    func testList() {
                multipartService?.list({ (tasks) -> Void in
                    println("tasks \(tasks)")
                }, onFail: { (code, msg) -> Void in
                    println(msg)
                }, fileNameLike: nil, fileMD5Equal: nil)
    }
    
    func testUploadPart() {
                multipartService?.getParts({ (parts) -> Void in
                    println(parts)
                }, onFail: { (code, msg) -> Void in
                    println(msg)
                }, uploadId: UPLOAD_ID)
    }
    
    func testDeleteParts() {
        
                multipartService?.initMultipart({ (uploadId) -> Void in
        
                    self.uploadId = uploadId
                    
                    var partKeys = [String]()
        
                    var uploadPart = { (part : UInt, afterSuccess : () -> Void) -> Void in
        
                        println(afterSuccess)
                        self.multipartService?.uploadPart({ (partKey, partMD5) -> Void in
        
                            //test delete
                            multipartService?.deleteParts({ () -> Void in
                                println("success")
                                
                                }, onFail: { (code, msg) -> Void in
                                    println(msg)
                                }, partKeys: [partKey])
        //
                        }, onFail: self.onFail, uploadId: uploadId, filePath: self.VIDEO, partNumber: part)
                    }
        
                    var complete = {() -> Void in
                        multipartService?.complete({ (video : Video, msg : String) -> Void in
                            println("-------> ")
                            println(video)
                        }, onFail: onFail, uploadId: uploadId, partKeys: partKeys, catalogId: CATALOG_ID)
                    }
        
                    uploadPart(1, {() -> Void in
                    })
                    //call complete
                    
                }, onFail: onFail, fileName: "trailer.mp4", fileMD5: LocalFile(contentsOfFile: VIDEO)!.md5())
        

    }
}
