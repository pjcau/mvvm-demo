//
//  ConvertedObject.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 03/07/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import Foundation

public class ConvertedObject {
    private(set) public var fromType:ConversionType?
    private(set) public var toType:ConversionType?
    
    private(set) public var listCurrency : [String:String] = [:]
    private(set) public var listCurrencyWithquotes : [String:Float] = [:]

    init(fromType:ConversionType = .Dollar, toType:ConversionType = .Euro ,currencyList:[String:String],listCurrencyWithquotes:[String:Float] =  [:]) {
        self.fromType = fromType
        self.toType = toType
        self.listCurrency = currencyList
        self.listCurrencyWithquotes = listCurrencyWithquotes
    }
    
    func allCurrenciesToString() -> String {
        let keys = self.allCurrencies()
        let stringRepresentationJson = keys.joined(separator: ",")
        
        return stringRepresentationJson
    }
    
    func allCurrencies() -> [String] {
        let keys:[String] = self.listCurrency.flatMap(){  $0.0  }

        return keys.sorted(){$0 < $1}
    }
    
    func getWithQuote(_ quote:[String:Float]) -> ConvertedObject {
      
        return ConvertedObject(fromType:self.fromType!,toType:self.toType!, currencyList:self.listCurrency, listCurrencyWithquotes:quote)

    }
  
    
    
}
