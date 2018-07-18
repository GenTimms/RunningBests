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
    
    func testStravaDecoding() {
        
        if let path = Bundle.main.path(forResource: "AthleteJSON", ofType: "json") {
          
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                print("Data: \(data)")
                //let jsonString = String(data: data, encoding: .utf8)
                //print("JsonString: \(jsonString)")
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let runs = try decoder.decode([Run].self, from: data)
                print("Runs: \(runs)")
                //let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                //if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["person"] as? [Any] {
                    // do stuff
                } catch {
                print("Couldn't get json from file duhhh")
            }
        }

    }
}
