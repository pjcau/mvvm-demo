//
//  Configuration.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 21/08/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import Foundation

struct Config {
    static let urlSession: URLSession = UITesting() ? MockURLSession() : URLSession.defaultSession()
}

private func UITesting() -> Bool {
    return ProcessInfo.processInfo.arguments.contains("UI-TESTING")
}
