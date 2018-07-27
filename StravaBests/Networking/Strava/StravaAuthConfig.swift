//
//  APIConfig.swift
//  StravaBests
//
//  Created by Genevieve Timms on 24/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

struct StravaAuthConfig {
    
    static var ClientID = "26550"
    static var ClientSecret = "4a621ec026ee39f917c2892e26428935221b0ae6"
    static var PublicAccessToken = "bfa3fa512b9287d696c32a9f1a5b436e888f8309"
    static var Scope = "view_private"
    static var Redirect = "https://com.gmjt.stravabests"
    static var AthleteID = "19474797"
    
    //AUTH RESULT: https://com.gmjt.stravabests/?state=&code=2f12da642ba4fae4c9ff204c5c8524199cce2667&scope=view_private

    
    //$ http GET "https://www.strava.com/api/v3/athlete/activities?before=&after=&page=&per_page=" "Authorization: Bearer [[token]]"
    
    //timeIntervalSince1970 multiply the return value by 1000 for before and after values
    
    //https://www.strava.com/api/v3/activities/1641511225?
    //access_token=bfa3fa512b9287d696c32a9f1a5b436e888f8309

    //https://www.strava.com/api/v3/athlete/activities?
    //access_token=bfa3fa512b9287d696c32a9f1a5b436e888f8309
    
    //https://www.strava.com/oauth/authorize?
    //client_id=26550&
    //redirect_uri=http:localhost/&
    //response_type=code&
    //scope=view_private
    
    func saveToFile() {
        
    }
    
    init(from file: Data) {
        
    }
}


