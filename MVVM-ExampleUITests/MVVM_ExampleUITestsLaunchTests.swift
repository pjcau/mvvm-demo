//
//  MVVM_ExampleUITestsLaunchTests.swift
//  MVVM-ExampleUITests
//
//  Created by CAU Jonny on 13/10/23.
//  Copyright © 2023 Pierre Jonny Cau. All rights reserved.
//

import XCTest

final class MVVM_ExampleUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app

        let attachment = XCTAttachment(screenshot: app.screenshot())
        attachment.name = "Launch Screen"
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
