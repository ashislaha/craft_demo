//
//  Craft_DemoTests.swift
//  Craft_DemoTests
//
//  Created by Ashis Laha on 7/17/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import XCTest
@testable import Craft_Demo

class Craft_DemoTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

extension Craft_DemoTests {
    
    // GET call
    func testGetData() {
        
        let successUrl = "https://httpbin.org/get"
        // NetworkLayer must return some value, successblock must execute
        NetworkLayer.getData(urlString: successUrl, successBlock: { (response) in
            XCTAssertNotNil(response)
        }, failed: { (error) in
            XCTAssertNil(error)
        })
        
        
        let failureUrl = "http://httpbin.org/get1"
        // NetworkLayer must return error because the end-point is invalid, error must execute
        NetworkLayer.getData(urlString: failureUrl, successBlock: { (response) in
            XCTAssertNil(response)
        }, failed: { (error) in
            XCTAssertNotNil(error)
        })
    }
    
    // update(POST/PUT/DELETE) call
    func testUpdateData() {
        let successUrl = "https://httpbin.org/post"
        let bodyDict = ["name": "ashis"]
        NetworkLayer.postData(urlString: successUrl, bodyDict: bodyDict, requestType: .POST, successBlock: { (response) in
            XCTAssertNotNil(response)
        }) { (error) in
            XCTAssertNil(error)
        }
        let failureUrl = "http://httpbin.org/post1"
        NetworkLayer.postData(urlString: failureUrl, bodyDict: bodyDict, requestType: .POST, successBlock: { (response) in
            XCTAssertNil(response)
        }) { (error) in
            XCTAssertNotNil(error)
        }
    }
    
}
