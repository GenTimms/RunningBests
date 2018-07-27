//
//  StravaParserTest.swift
//  StravaBestsTests
//
//  Created by Genevieve Timms on 17/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import XCTest
@testable import StravaBests

class CodableTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreateActivitiesFromData() {
        
        if let path = Bundle.main.path(forResource: "acitivities", ofType: "json") {
          
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                print("Data: \(data)")
              let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let activities = try decoder.decode([Activity].self, from: data)
                print("Runs: \(activities)")
                } catch {
                print("Couldn't get json from file")
            }
        }
    }
    
    func testCreateRunFromData() {
        if let path = Bundle.main.path(forResource: "run", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                print("Data: \(data)")
                let run = try Run(json: data)
                print("Runs: \(run.bests)")
                
            } catch {
                print("Couldn't get json from file \(error)")
            }
        }
    }
    
    func testDecodeBestsOnly() {
        if let path = Bundle.main.path(forResource: "run", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                print("Data: \(data)")
                  let decoder = JSONDecoder()
                if let bests = try? decoder.decode( [String: [Best]].self, from: data) {
                    print("Runs: \(bests)")
                } else {
                    throw JSONError.parseFailed
                }
            } catch {
                print("Couldn't get json from file \(error)")
            }
        }
        
    }
}
