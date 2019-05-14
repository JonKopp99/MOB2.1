//
//  keyChainExampleTests.swift
//  keyChainExampleTests
//
//  Created by Jonathan Kopp on 4/10/19.
//  Copyright © 2019 Jonathan Kopp. All rights reserved.
//

import XCTest
import KeychainSwift
@testable import keyChainExample

class keyChainExampleTests: XCTestCase {

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
    func testKeychainGet() {
        // Test if retrieving a value with Keychain works.
        let vc = ViewController()
        vc.viewDidLoad()
        XCTAssert(vc.getMessage() != nil)
    }
    
    func testKeychainDelete() {
        // Test if deleting a value with Keychain works.
        let vc = ViewController()
        vc.viewDidLoad()
        vc.deletePressed()
        XCTAssert(vc.getMessage() == "...")
    }
    
    func testKeychainUpdate() {
        // Test if updating a value with Keychain works, you will need an initial value and compare the new value with the old one.
        let vc = ViewController()
        vc.viewDidLoad()
        vc.textField.text = "PooPoo"
        vc.savePressed()
        XCTAssert(vc.getMessage() == "PooPoo")
        
    }

}
