//
//  URLSession+MainQueue.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 21/08/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import Foundation

extension URLSession {
    static func defaultSession() -> URLSession {
        return URLSession(configuration: URLSessionConfiguration.default,
                            delegate: nil, delegateQueue: OperationQueue.main)
    }
}
