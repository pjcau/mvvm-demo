//
//  ProductListTest.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 14/08/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import XCTest
@testable import MVVM_Example


class ProductListTest: XCTestCase {
    
    var productsList: ProductsList? = nil
    typealias eventTupleType = ( Event,  Bool,  Any)

    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.productsList = ProductsList()

    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialization() {
        
        XCTAssertNotNil(self.productsList, "The productsList should not be nil.")
        XCTAssertTrue(self.productsList?.products.count == 4, "The productsList should be equal to 4 items that was passed in.")
    }

    func testGetElements()
    {
        self.productsList?.getElement()
        
        self.productsList?.productListListener.bind(listener: { [weak self] (eventTuple: eventTupleType) in
            let products = eventTuple.2 as! [Product]
            XCTAssertTrue(self?.productsList?.products.count == products.count, "The productsList should be equal to value items that was passed in the closure.")
        })

    }
    
    func testGetTotalPrice()
    {
 
        self.productsList?.totalPrice()
        self.productsList?.productListListener.bind(listener: { [weak self] (eventTuple: eventTupleType) in
            let totalPrice = eventTuple.2 as! Float32
            XCTAssertTrue(self?.productsList?.getTotalPrice() == totalPrice, "The totalPrice should be equal to value totalPrice that was passed in the closure.")
        })
    }
    
    func testAddProducts()
    {
        
        self.productsList?.addProduct(product:Product(price: 0.95,good: .peas))

        self.productsList?.productListListener.bind(listener: { [weak self] (eventTuple: eventTupleType) in
            XCTAssertTrue(self?.productsList?.products.count == 5, "The productsList should be equal to value 5 that was passed in the closure.")
        })
    }
    
    func testRemoveProduct()
    {
        
        self.productsList?.removeProduct(product:(self.productsList?.products.last)!)
        
        self.productsList?.productListListener.bind(listener: { [weak self] (eventTuple: eventTupleType) in
            XCTAssertTrue(self?.productsList?.products.count == 3, "The productsList should be equal to value 5 that was passed in the closure.")
        })
    }
    
    func testRemoveAllProduct()
    {
        
        self.productsList?.removeAll()
        
        self.productsList?.productListListener.bind(listener: { [weak self] (eventTuple: eventTupleType) in
            XCTAssertTrue(self?.productsList?.products.count == 0, "The productsList should be equal to value 5 that was passed in the closure.")
        })
    }
    
    func modifyProduct()
    {
        
        let quantityModded : Int32  = 30
        self.productsList?.modifyProduct(product: (self.productsList?.products.last)!, quantity: UInt32(quantityModded))
        
        
        self.productsList?.productListListener.bind(listener: { (eventTuple: eventTupleType) in
            
            let (allProducts, index) = eventTuple.2 as! ([Product], Int)

            let productModded = allProducts[index]
            
            XCTAssertTrue((productModded.quantity)! == quantityModded, "The productModded quantity should be equal to value quantityModded that was passed in the closure.")
        })
        
    }
    
}
