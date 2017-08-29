//
//  ConvertedObjectTest.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 23/08/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import XCTest
@testable import MVVM_Example


class ConvertedObjectTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    
    func testInitObject() {
        
        let mockarrayList = ["first":"EUR", "second":"USD","third":"UK"]
        let convertedObject = ConvertedObject.init(currencyList:mockarrayList)
        
        XCTAssertNotNil(convertedObject, "The ConvertedObject should not be nil.")
        XCTAssertTrue(convertedObject.listCurrency! == mockarrayList, "The convertedObject listCurrency should be equal to value mockarray.")
        
    }
    
    func testObjectWithSecondInit() {
        
        let mockarrayList = ["first":"EUR", "second":"USD","third":"UK"]
        let mockarrayValue :[String:Float] = ["first":1.0, "second":1.2,"third":0.8]
        
        let conversionFromType:ConversionType = .Dollar
        let conversionToType:ConversionType = .Euro
        
        let convertedObject = ConvertedObject.init(fromType: conversionFromType, toType: conversionToType, currencyList: mockarrayList, listCurrencyWithquotes: mockarrayValue)
        
        XCTAssertNotNil(convertedObject, "The ConvertedObject should not be nil.")
        
        XCTAssertTrue(convertedObject.listCurrency! == mockarrayList, "The convertedObject listCurrency should be equal to value mockarrayList.")
        
        XCTAssertTrue(convertedObject.listCurrencyWithquotes! == mockarrayValue, "The convertedObject listValue should be equal to value mockarrayValue.")
        
        XCTAssertTrue(convertedObject.fromType == conversionFromType, "The convertedObject fromType should be equal to value conversionFromType.")
        
        XCTAssertTrue(convertedObject.toType == conversionToType, "The convertedObject toType should be equal to value conversionToType.")
        
        
    }
    
    func test_allCurrenciesToString()
    {
   
        let mockarrayList : Dictionary<String,String
            > = ["first":"EUR","second":"USD","third":"UK"]
        let convertedObject = ConvertedObject.init(currencyList:mockarrayList)
                
        XCTAssertNotNil(convertedObject.allCurrenciesToString(), "The ConvertedObject allCurrenciesToString() should not be nil.")
        
        XCTAssertEqual(mockarrayList.keysForValue(value: "EUR").first, "first")
        XCTAssertEqual(mockarrayList.keysForValue(value: "USD").first, "second")
        XCTAssertEqual(mockarrayList.keysForValue(value: "UK").first, "third")
        
        XCTAssertNotNil(convertedObject.allCurrenciesToString().range(of:"first"))
        XCTAssertNotNil(convertedObject.allCurrenciesToString().range(of:"second"))
        XCTAssertNotNil(convertedObject.allCurrenciesToString().range(of:"third"))

    }
    
}
