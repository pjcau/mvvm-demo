//
//  MVVM_ExampleUITests_Home.swift
//  MVVM-ExampleUITests
//
//  Created by CAU Jonny on 13/10/23.
//  Copyright © 2023 Pierre Jonny Cau. All rights reserved.
//

import Foundation

import XCTest

class MVVM_ExampleUITests_Home: XCTestCase {
  let app = XCUIApplication()

  override func setUpWithError() throws {
    continueAfterFailure = false
    app.launch()
  }
    
    func testNavigation() {
      XCTAssert(app.staticTexts["Basket List"].exists)
    }
}
