//
//  ProductsListVMTest.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 12/08/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import XCTest
@testable import MVVM_Example

class ProductsListVMTest: XCTestCase {
    
    var productsList: ProductsList? = nil
    var tableVC: UITableViewController? = nil
    var productsListViewModel :ProductsListViewModel? = nil
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        tableVC = storyboard.instantiateViewController(withIdentifier: "ListTableViewController") as? UITableViewController
        
        // Trigger view load and viewDidLoad()
        _ = tableVC?.view
        
        self.productsList = ProductsList()
        
        // Initialize Profile View Model
        self.productsListViewModel = ProductsListViewModel(withProductsList:self.productsList!)


    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInitialization() {
        
        XCTAssertNotNil(self.productsListViewModel, "The productsList view model should not be nil.")
        XCTAssertTrue(self.productsListViewModel?.productsList === self.productsList, "The productsList should be equal to the profile that was passed in.")
        
    }

    func testTotalTableElements() {
        
        let tableView = tableVC?.tableView
        
        let elements =  self.productsListViewModel?.numberOfRowInTableView()
        
        XCTAssertNotNil(tableView, "The tableView  should not be nil.")
        XCTAssertTrue(elements == 4, "The elements should be equal to 4 that was passed in.")
        
    }
    
    
}

