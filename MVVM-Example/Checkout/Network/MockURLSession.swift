//
//  MockURLSession.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 21/08/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import Foundation


typealias DataCompletion = (Data?, URLResponse?, Error?) -> Void

class MockURLSession: URLSession {
    
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    var nextUrlResponse:URLResponse?
    
    private (set) var lastURL: URL?
    
    func httpURL(url: URL, andCode:Int ) -> URLResponse {
        return HTTPURLResponse(url: url, statusCode: andCode, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    override func dataTask(with url: URL, completionHandler: @escaping DataCompletion) -> URLSessionDataTask {
        lastURL = url
        let urlResponse: URLResponse = nextUrlResponse ?? httpURL(url: url, andCode: 200)
        completionHandler(nextData, urlResponse, nextError)
        return nextDataTask
    }
    
}


class MockURLSessionDataTask: URLSessionDataTask {
    private (set) var resumeWasCalled = false
    
    override func resume() {
        resumeWasCalled = true
    }
}
