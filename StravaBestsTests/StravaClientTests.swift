//
//  StravaClientTests.swift
//  StravaBestsTests
//
//  Created by Genevieve Timms on 23/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import XCTest
@testable import StravaBests

class StravaClientTests: XCTestCase {
    
    let client = StravaClient()
    
    override func setUp() {
        super.setUp()
        client.token = StravaAuthConfig.PublicAccessToken
    }
    
    override func tearDown() {
        super.tearDown()
    }
 
    func testFetchRun_getsRun() {
        var run: Run? = nil
        let runExpectation = expectation(description: "Fetch")
        
        let activity = Activity(id: 1665166078, name: "Trosley 10k", date: Date(), distance: 10164.0, type: "Run")
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
    
    func testFetchActivites_getsActivites() {
        var activities: [Activity]? = nil
        let activitiesExpectation = expectation(description: "Fetch")
        
        client.fetchRunList { result in
            switch result {
            case .success(let fetchedActivities): print("Success! Activities: \(fetchedActivities)"); activities = fetchedActivities
            case .failure(let error): print("Failure! Error: \(error)")
            }
            activitiesExpectation.fulfill()
        }
        waitForExpectations(timeout: 10) { (error) in
            print("Expectations Fulfilled")
        }
        XCTAssertNotNil(activities)
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
