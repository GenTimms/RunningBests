//
//  StravaParserTest.swift
//  StravaBestsTests
//
//  Created by Genevieve Timms on 17/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import XCTest
@testable import StravaBests


class StravaParserTest: XCTestCase {
    
    let stravaParser = StravaParser()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEnumProtocolType() {
        print(stravaParser.codingKeys)
    }
    
}
