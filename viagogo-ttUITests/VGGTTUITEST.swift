//
//  VGGTTUITEST.swift
//  viagogo-tt
//
//  Created by Daniel-Ernest Luff on 24/03/2016.
//  Copyright © 2016 toutright. All rights reserved.
//

import XCTest

class VGGTTUITEST: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func singleTap() {
        
        let app = XCUIApplication()
        app.tables.cells.staticTexts["Algeria"].tap()
        app.navigationBars["Algeria"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        self.tearDown()
        
    }
    
    func borders() {
        
        let app = XCUIApplication()
        app.navigationBars["Andorra"].childrenMatchingType(.Button).matchingIdentifier("Back").elementBoundByIndex(0).tap()
        
        let tablesQuery = app.tables
        tablesQuery.staticTexts["Andorra"].tap()
        tablesQuery.staticTexts["France"].tap()
        self.tearDown()
        
    }
    
    func regions() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.cells.containingType(.StaticText, identifier:"Afghanistan").staticTexts["Asia"].tap()
        app.buttons["Asia"].tap()
        tablesQuery.cells.containingType(.StaticText, identifier:"Bhutan").staticTexts["Asia"].tap()
        self.tearDown()
    }
    
}
