//
//  Logger.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 04/07/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import Foundation


import Foundation

// Enum for showing the type of Log Types
enum LogEvent: String {
    case e = "[😡]" // error
    case i = "[😜]" // info
    case d = "[🙈]" // debug
    case v = "[😷]" // verbose
    case w = "[🙃]" // warning
    case s = "[😤]" // severe
}

class Logger {
    
    static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS"
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    class func log(message: String,
                   event: LogEvent,
                   fileName: String = #file,
                   line: Int = #line,
                   column: Int = #column,
                   funcName: String = #function) {
        
        #if DEBUG
            print("\(Date().toString()) \(event.rawValue)[\(sourceFileName(filePath: fileName))]:\(line) \(column) \(funcName) -> \(message)")
        #endif
    }
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}

internal extension Date {
    func toString() -> String {
        return Logger.dateFormatter.string(from: self as Date)
    }
}
