//
//  UITestingDemoUITests.swift
//  UITestingDemoUITests
//
//  Created by Tim Mitra on 2024-02-16.
//

import XCTest
@testable import UITestingDemo

final class UITestingDemoUITests: XCTestCase {
  
  let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
      app.launch()

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


  func testWelcome() throws {
    
    let welcome = app.staticTexts["Welcome!"]
    XCTAssert(welcome.exists)
    XCTAssertEqual(welcome.label, "Welcome!")
  }
  
  func testLoginButton() throws {
   
      let login = app.buttons["loginButton"]
      XCTAssert(login.exists)
  }
  
  func testLoginFormAppearance() throws {
    app.buttons["loginButton"].tap()
    let loginNavBarTitle = app.staticTexts["Login"]
    XCTAssert(loginNavBarTitle.waitForExistence(timeout: 0.5))
  }
  
  func testLoginForm() throws {
    app.buttons["Login"].tap()
    
    let navBar = app.navigationBars.element
    XCTAssert(navBar.exists)
    
    let username = app.textFields["Username"]
    XCTAssert(username.exists)
    
    let password = app.secureTextFields["Password"]
    XCTAssert(password.exists)
    
    let login = app.buttons["loginNow"]
    XCTAssert(login.exists)
    XCTAssertEqual(login.label, "Login")
    
    let dismiss = app.buttons["Dismiss"]
    XCTAssert(dismiss.exists)
  }
  
  func testLoginDismiss() throws {
    app.buttons["Login"].tap()
    let dismiss = app.buttons["Dismiss"]
    dismiss.tap()
    XCTAssertFalse(dismiss.waitForExistence(timeout: 0.5))
  }
  
  func testUsername() throws {
    app.buttons["Login"].tap()
    
    let username = app.textFields["Username"]
    username.tap()
    username.typeText("test")
    
    XCTAssertNotEqual(username.value as! String, "")
  }
  
  func testPassword() throws {
    app.buttons["Login"].tap()
    
    app.secureTextFields.element.tap()
    app.keys["p"].tap()
    app.keys["a"].tap()
    app.keys["s"].tap()
    app.keys["s"].tap()
    app.keyboards.buttons["Return"].tap()

    XCTAssertNotEqual(app.secureTextFields.element.value as! String, "")
  }
  
  func testLogin() throws {
    app.buttons["Login"].tap()
    
    app.textFields.element.tap()
    app.textFields.element.typeText("test")
    
    app.secureTextFields.element.tap()
    app.secureTextFields.element.typeText("pass")
    app.keyboards.buttons["Return"].tap()
    
    let loginButton = app.buttons["loginNow"]
    loginButton.tap()
    
    XCTAssertFalse(loginButton.waitForExistence(timeout: 0.5))
  }
  
  func testFailedLoginAlert() throws {
      app.buttons["Login"].tap()
      app.buttons["loginNow"].tap()
   
      XCTAssert(app.alerts.element.waitForExistence(timeout: 0.5))
   
      app.alerts.element.buttons["OK"].tap()
      XCTAssertFalse(app.alerts.element.exists)
  }
 
  // MARK: - Login Tests
  func login() throws {
      app.buttons["Login"].tap()
   
      app.textFields.element.tap()
      app.textFields.element.typeText("test")
   
      app.secureTextFields.element.tap()
      app.secureTextFields.element.typeText("pass")
      app.keyboards.buttons["Return"].tap()
   
      app.buttons["loginNow"].tap()
  }
  
  func testWelcomeAfterLogin() throws {
    XCTAssert(app.staticTexts["Welcome!"].exists)
    
    try login()
    
    XCTAssert(app.staticTexts["Welcome test!"].exists)
    XCTAssertFalse(app.staticTexts["Welcome!   "].exists)
  }
  
  func testLoginLogoutLabel() throws {
    XCTAssertEqual(app.buttons["loginButton"].label, "Login")
    
    try login()
    
    XCTAssertEqual(app.buttons["loginButton"].label, "Logout")
  }
  
  func testLogout() throws {
    try login()
    
    XCTAssert(app.staticTexts["Welcome test!"].exists)
    XCTAssertEqual(app.buttons["loginButton"].label, "Logout")
    
    app.buttons["loginButton"].tap()
    
    XCTAssert(app.staticTexts["Welcome!"].exists)
    XCTAssertEqual(app.buttons["loginButton"].label, "Login")
  }
  
  // MARK: Prefs tests
  func testColorTheme() throws {
    try login()
    
    let colorTheme = app.segmentedControls["colorTheme"]
    XCTAssert(colorTheme.exists)
    XCTAssert(colorTheme.buttons["Light"].isSelected)
    
    colorTheme.buttons["Dark"].tap()
    XCTAssert(colorTheme.buttons["Dark"].isSelected)
  }
  
  func testTextSize() throws {
    try login()
    
    let textSize = app.sliders["slider"]
    XCTAssert(textSize.exists)
    
    textSize.adjust(toNormalizedSliderPosition: 0.75)
    XCTAssertGreaterThanOrEqual(textSize.value as! String, "0.7")
  }
  
  func testFontPicker() throws {
    try login()
    
    let wheel = app.pickerWheels.element
    // let wheel = app.pickers["fontPicker"].pickerWheels.element // also a valid way
    XCTAssert(wheel.exists)
    XCTAssertEqual(wheel.value as! String, "Arial")
    
    wheel.adjust(toPickerWheelValue: "Futura")
    XCTAssertEqual(wheel.value as! String, "Futura")
  }
}
