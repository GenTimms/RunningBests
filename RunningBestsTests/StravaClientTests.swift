//
//  StravaClientTests.swift
//  StravaBestsTests
//
//  Created by Genevieve Timms on 23/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import XCTest
@testable import RunningBests

class StravaClientTests: XCTestCase {
    
    let client = StravaClient()
    
    override func setUp() {
        super.setUp()
        client.token = "80e0b3ad850d90fe465db2ac16fbfb588c875e98" //update to current token
    }
    
    override func tearDown() {
        super.tearDown()
    }
 
    func testFetchRun_getsRun() {
        var run: Run? = nil
        let runExpectation = expectation(description: "Fetch")
        
        let activity = Activity(id: 1748271511, name: "Trosley", date: Date(), distance: 10000.0, type: "Run", time: 4000)
        let partialRun = Run(activity: activity)
        client.fetchRunDetails(for: partialRun) { result in
            switch result {
            case .success(let fetchedRun): print("Success! Run: \(fetchedRun)"); run = fetchedRun
            case .failure(let error): print("Failure! Error: \(error)")
            }
            runExpectation.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
            print("Expectations Fulfilled")
        }
        XCTAssertNotNil(run)
    }
    
    func testFetchRuns_getRuns() {
        var runs: Runs? = nil
        let runsExpectation = expectation(description: "Fetch")
        
        client.fetchRuns { result in
            switch result {
            case .success(let fetchedRuns): print("Success! Partial Runs: \(fetchedRuns)"); runs = fetchedRuns
            case .failure(let error): print("Failure! Error: \(error)")
            }
            runsExpectation.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
            print("Expectations Fulfilled")
        }
        XCTAssertNotNil(runs)
    }
    
    func fetchToken_getsToken() {
        let tokenExpectation = expectation(description: "Token")
        
        let code = "fc5eecc8c3f8c3c615ebe47f4e50fc863e1e34da"
        var token: String? = nil
        
        client.fetchToken(accessCode: code) { result in
            switch result {
            case .success(let fetchedToken): print("Success! Token: \(fetchedToken)"); token = fetchedToken
            case .failure(let error): print("Failure! Error: \(error)")
            }
            tokenExpectation.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
            print("Expectations Fulfilled")
        }
        XCTAssertNotNil(token)
    }
}
