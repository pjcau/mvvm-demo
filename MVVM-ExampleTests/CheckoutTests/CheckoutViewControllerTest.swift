//
//  CheckoutViewControllerTest.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 22/08/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import XCTest
@testable import MVVM_Example

class CheckoutViewControllerTest: XCTestCase {
    
    var checkOutVC: UIViewController? = nil

    
    override func setUp() {
        super.setUp()        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        self.checkOutVC = storyboard.instantiateViewController(withIdentifier: "CheckOutViewControllerID")
        
        // Trigger view load and viewDidLoad()
        _ = self.checkOutVC?.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTableViewOutlet() {
        XCTAssertNotNil(self.checkOutVC?.view)
    }
    
    //Mark - test on Picker View
    
    func testThatViewConformsToUIPickerViewDataSource() {
        XCTAssertTrue( (checkOutVC?.conforms(to: UIPickerViewDataSource.self))!, "View does not conform to PickerView datasource protocol")
    }
    
    func testThatViewConformsToPickerViewDelegate() {
        XCTAssertTrue( (checkOutVC?.conforms(to: UIPickerViewDelegate.self))!, "View does not conform to UIPickerView delegate protocol")
    }
/*
    
    func testThatPickerViewHasDataSource() {
        XCTAssertNotNil(checkOutVC?.convertCurrrencyPickerView.dataSource, "PickerView datasource cannot be nil")
    }
    
    
    func testViewControllerIsConnectedToDelegate() {
        XCTAssertNotNil(checkOutVC?.convertCurrrencyPickerView.delegate, "PickerView delegate cannot be nil")
    }
 */
    
    
    
}
