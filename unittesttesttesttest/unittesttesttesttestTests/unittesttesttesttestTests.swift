//
//  unittesttesttesttestTests.swift
//  unittesttesttesttestTests
//
//  Created by Jonathan Kopp on 4/8/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import XCTest
@testable import unittesttesttesttest

class unittesttesttesttestTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    func testPlaceHolder()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! ViewController
        viewController.viewDidLoad()
        print(viewController.textField.placeholder!)
        XCTAssertEqual(viewController.textField.placeholder!, "This is a textfield.")
    }
    
    func testStupidVowelThing()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! ViewController
        viewController.viewDidLoad()
        print(viewController.textField.placeholder!)
        XCTAssertEqual(viewController.vowelsInAString(string: "FUUCK"), 2)
    }
    
    func testStupidTitleThing()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateInitialViewController() as! ViewController
        viewController.viewDidLoad()
        print(viewController.textField.placeholder!)
        XCTAssertEqual(viewController.makeTitle(string: "my name is swole jon"),"My Name Is Swole Jon ")
    }
    
}
