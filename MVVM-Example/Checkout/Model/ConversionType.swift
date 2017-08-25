//
//  ConversionType.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 03/07/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import Foundation

public enum ConversionType {
    case Euro
    case Dollar
    
    var value: String {
        switch self {
        case .Euro:
            return "EUR"
        case .Dollar:
            return "USD"
            
        }
    }
}

 
