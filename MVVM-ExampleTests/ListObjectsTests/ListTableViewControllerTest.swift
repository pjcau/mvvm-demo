//
//  ListTableViewControllerTest.swift
//  MVVM-Example
//
//  Created by Pierre jonny cau on 14/08/2017.
//  Copyright © 2017 Pierre Jonny Cau. All rights reserved.
//

import XCTest
@testable import MVVM_Example

class ListTableViewControllerTest: XCTestCase {
    
    var tableVC: UITableViewController? = nil
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        tableVC = storyboard.instantiateViewController(withIdentifier: "ListTableViewController") as? UITableViewController
        
        // Trigger view load and viewDidLoad()
        _ = tableVC?.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testTableViewOutlet() {
        XCTAssertNotNil(tableVC?.tableView)
    }
   
    //Mark - test on Table view
    
    func testThatViewConformsToUITableViewDataSource() {
        XCTAssertTrue( (tableVC?.conforms(to: UITableViewDataSource.self))!, "View does not conform to UITableView datasource protocol")
    }
    
    func testThatTableViewHasDataSource() {
        XCTAssertNotNil(tableVC?.tableView.dataSource, "Table datasource cannot be nil")
    }
    
    func testThatViewConformsToUITableViewDelegate() {
        XCTAssertTrue( (tableVC?.conforms(to: UITableViewDelegate.self))!, "View does not conform to UITableView delegate protocol")
    }
    
    func testTableViewIsConnectedToDelegate() {
        XCTAssertNotNil(tableVC?.tableView.delegate, "Table delegate cannot be nil")
    }
    
    func testTableViewNumberOfRowsInSection() {
        let expectedRows = 4
        XCTAssertTrue( tableVC?.tableView.numberOfRows(inSection: 0) == expectedRows , "Table don't have 4 rows")
    }
 
}
