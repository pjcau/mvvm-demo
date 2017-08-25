//
//  ProductTest.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 16/08/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import XCTest
@testable import MVVM_Example

class ProductTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitObject() {
        
        XCTAssertNotNil(Product(price: 0.95,good: .peas), "The product should not be nil.")
        
    }
    
    func testcChangeQuantity()
    {
        
        let quantityModded : Int32  = 30
        
        let product = Product(price: 0.95,good: .peas)
        
        let changeProduct = product.changeQuantity(quantity: UInt32(quantityModded))
        
        XCTAssertTrue((changeProduct.quantity)! == quantityModded, "The productModded quantity should be equal to value quantityModded.")
    }
    
    
    
}
