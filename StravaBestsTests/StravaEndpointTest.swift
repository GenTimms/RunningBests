//
//  StravaEndpointTest.swift
//  StravaBestsTests
//
//  Created by Genevieve Timms on 26/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import XCTest
@testable import StravaBests

class StravaEndpointTests: XCTestCase {
    
    static var ActivityID = "1641511225"
    static var Token = "bfa3fa512b9287d696c32a9f1a5b436e888f8309"

    let activitiesURL = URL(string: "https://www.strava.com/api/v3/athlete/activities?before&after&per_page=200")
    let activityURL = URL(string: "https://www.strava.com/api/v3/activities/\(StravaEndpointTests.ActivityID)?")
    let authorizeURL = URL(string: "https://www.strava.com/api/v3/oauth/authorize?client_id=\(StravaAuthConfig.ClientID)&redirect_uri=\(StravaAuthConfig.Redirect)&response_type=code&scope=\(StravaAuthConfig.Scope)")
    let tokenURL = URL(string: "https://www.strava.com/api/v3/oauth/token?client_id=\(StravaAuthConfig.ClientID)&client_secret=\(StravaAuthConfig.ClientSecret)")

    
    func testEndpointURLs_equalStravaAPIURLs() {
        
        //Activites
        let endpointActivitesURL = Strava.activities().url
        XCTAssertEqual(endpointActivitesURL, activitiesURL)
        
        //Activity
        let endpointActivityURL = Strava.activity(id: StravaEndpointTests.ActivityID).url
        XCTAssertEqual(endpointActivityURL, activityURL)
        
        //Authorization
        let endpointAuthorizeURL = Strava.authorize.url
        XCTAssertEqual(endpointAuthorizeURL, authorizeURL)
        
        //Token
        let endpointTokenURL = Strava.token(code: StravaEndpointTests.Token).url
        XCTAssertEqual(endpointTokenURL, tokenURL)
    }
    
    func testEndpointRequest_equalsURLRequest() {
        let endpointActivitiesRequest = Strava.activities(before: nil, after: nil).request
        XCTAssertEqual(endpointActivitiesRequest, URLRequest(url: activitiesURL!))
    }
    
    func testEndpointRequestWithAuthorizationHeader_equalsAuthRequest() {
        let endPointActivitiesRequestWithAuthHeader = Strava.activities(before: nil, after: nil).requestWithAuthorizationHeader(oauthToken: StravaEndpointTests.Token)
        var request = URLRequest(url: activitiesURL!)
        request.addValue("Bearer \(StravaEndpointTests.Token)", forHTTPHeaderField: "Authorization")
        XCTAssertEqual(endPointActivitiesRequestWithAuthHeader, request)
    }

}
