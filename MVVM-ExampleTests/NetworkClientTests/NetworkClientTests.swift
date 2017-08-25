//
//  NetworkClientTests.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 22/08/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import XCTest
@testable import MVVM_Example

class NetworkClientTests: XCTestCase {
    
    var httpClient: NetworkClient!
    let session = MockURLSession()
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        httpClient = NetworkClient(session: session)

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_get_request_with_URL() {
        
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        
        httpClient.get(url: url) { (success, response) in
            // Return data
        }
        
        XCTAssert(session.lastURL == url)
        
    }
    
    func test_get_resume_called() {
        
        let dataTask = MockURLSessionDataTask()
        session.nextDataTask = dataTask
        
        guard let url = URL(string: "https://mockurl") else {
            fatalError("URL can't be empty")
        }
        
        httpClient.get(url: url) { (success, response) in
            // Return data
        }
        
        XCTAssert(dataTask.resumeWasCalled)
    }
    
    func test_get_should_return_data() {
        let expectedData = "{}".data(using: .utf8)
        
        session.nextData = expectedData
        
        var actualData: [String: Any] = ["":""]
        httpClient.get(url: URL(string: "http://mockurl")!) { (data, error) in
            actualData = data!
        }
        
        XCTAssertNotNil(actualData)
    }
    
    func test_400_Error_data() {
        let expectedData = "{}".data(using: .utf8)
        let url = URL(string: "http://mockurl")!
        var actualError :Error?
        
        session.nextData = expectedData
        session.nextUrlResponse = session.httpURL(url: url, andCode: 400)
        
        var actualData: [String: Any]? = nil
        httpClient.get(url: url) { (data, error) in
            actualData = data
            actualError = error
        }
        
        XCTAssertNil(actualData)
        XCTAssertNotNil(actualError)

    }
    
    
    func test_isSuccessHTTPCode_data() {
        let expectedData = "{}".data(using: .utf8)
        let url = URL(string: "http://mockurl")!
        var actualError :Error?
        
        session.nextData = expectedData
        session.nextUrlResponse = session.httpURL(url: url, andCode: 205)
        
        var actualData: [String: Any]? = nil
        httpClient.get(url: url) { (data, error) in
            actualData = data
            actualError = error
        }
        
        XCTAssertNotNil(actualData)
        XCTAssertNil(actualError)
        
    }

}


