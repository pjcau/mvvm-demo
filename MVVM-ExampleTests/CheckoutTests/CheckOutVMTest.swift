//
//  CheckOutVMTest.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 24/08/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import XCTest
@testable import MVVM_Example

class CheckOutVMTest: XCTestCase {
    
    var productList :ProductsList? = nil
    
    var convertedObject:ConvertedObject? = nil
    
    var checkOutViewModel :CheckOutViewModel? = nil

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitObject() {
        self.productList = ProductsList()

        let checkOutVM = CheckOutViewModel.init(passProductlist: self.productList!)
        
        XCTAssertNotNil(checkOutVM, "The checkOutVM should not be nil.")
        XCTAssertTrue(checkOutVM.productsList === self.productList!, "The checkOutVM productList should be equal to value self.productsList.")
        
    }
    
    func test_operation_event() {
        
        let quantityModded : Int32  = 30
        
        let mockPeas = Product(price: 0.95,good: .peas, quantity:quantityModded)
        
        let resultMock :Float32 = (Float32(quantityModded)*(mockPeas.price)!)

        let productList = ProductsList.init([mockPeas,Product(price: 2.10,good: .eggs),Product(price: 1.30,good: .milk),Product(price: 0.73,good: .beans)])
        productList.totalPrice()

        productList.productListListener.bind(listener: {  (eventTuple: (Event,Bool,Any)) in
            XCTAssertTrue(.totalPrice == eventTuple.0, "The .totalPrice  should be equal to value mockTuple.0")
            XCTAssertTrue(true == eventTuple.1, "The true  should be equal to value mockTuple.1")
            XCTAssertTrue((eventTuple.2 as! Float32) == resultMock, "The productList resultMock should is  be equal to value resultMock " )
        })
    }
    
    func test_pickerViewFromVM_titleForRow()
    {
        self.productList = ProductsList()
        self.checkOutViewModel = CheckOutViewModel.init(passProductlist: self.productList!)
        let row = 1
        
        let mockarrayList = ["alpha":"EUR", "beta":"USD","gamma":"UK"]
        let convertedObject = ConvertedObject.init(currencyList:mockarrayList)
        
        self.checkOutViewModel?.currencySupported = convertedObject

        let key :String? = self.checkOutViewModel?.pickerViewFromVMfromTitle(row)
        XCTAssertTrue(key == "beta - USD", "The key  should be equal to value first")

    }
    
    func pickerViewFromVM_didSelectRow()
    {
        
    }
    
}
