//
//  SDKCatalogTest.swift
//  SDKDemo
//
//  Created by kinghai on 7/3/15.
//  Copyright (c) 2015 ftguang. All rights reserved.
//

import UIKit
import XCTest
import AppDemo

class SDKCatalogTest: XCTestCase {

    var catalogService : CatalogService?
    
    let CATALOG_ID = "1"
    let CATALOG_NAME = "testBySwift"
    
    override func setUp() {
        super.setUp()
        
        catalogService = getSDK().getCatalogService()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func onFail(code : Int?, msg : String) -> Void {
        println("code is \(code), msg is \(msg)")
        XCTFail("fail")
    }
    
    func testList() {
        catalogService?.list({ (catalogs : [Catalog]) -> Void in
            
            XCTAssertGreaterThan(catalogs.count, 0, "")
            
            }, onFail: onFail)
    }
    
    func testGet() {
        catalogService?.get({ (catalog : Catalog) -> Void in
            
            XCTAssertNotNil(catalog, " ")

        }, onFail: onFail, id: self.CATALOG_ID)
    }
    
    func testCreateAndDelete() {
        catalogService?.create({ (catalog : Catalog) -> Void in
            
            XCTAssertEqual(self.CATALOG_NAME, catalog.name, " ")
            
            self.catalogService?.delete({ (catalog) -> Void in
                
                    XCTAssertEqual(self.CATALOG_NAME, catalog.name, " ")
                
                }, onFail: self.onFail, id: catalog.id)

            
        }, onFail: onFail, name: CATALOG_NAME)
    }
}