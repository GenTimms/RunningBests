//
//  StravaParserTest.swift
//  StravaBestsTests
//
//  Created by Genevieve Timms on 17/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import XCTest
@testable import RunningBests

class CodableTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCreateActivitiesFromData() {
        
        if let path = Bundle.main.path(forResource: "activities", ofType: "json") {
          
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
    
    func testEncodeRunToJSON() {
        let activity = Activity(id: 12345678, name: "Test Activity", date: Date(), distance: 10000, type: "Run", time: 4000)
      
        let run = Run(activity: activity)
        var fastBests = [Distance: Int]()
        for distance in Distance.all(upto: run.distance) {
            fastBests[distance] = 10
        }
        
        run.bests = fastBests
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        let json = try? encoder.encode(run)
        print(String(data: json!, encoding: .utf8)!)
    }
}
