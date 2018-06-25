//
//  StravaEndpoint.swift
//  StravaBests
//
//  Created by Genevieve Timms on 25/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

enum Strava {
    case activities(before: Int?, after: Int?)
    case activity(id: String)
    case authorize
    case token(code: String?)
}

extension Strava: Endpoint {
    var base: String {
        return "https://www.strava.com/api/v3/"
    }
    
    var path: String {
        switch self {
        case .activities: return "athlete/activities"
        case .activity(let id): return "activities/\(id)"
        case .authorize: return "oauth/authorize"
        case .token: return "oauth/token"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .activities(let before, let after):
            return [
                URLQueryItem(name: "before", value: before?.description),
                URLQueryItem(name: "after", value: after?.description)
            ]
        case .activity: return []
        case .authorize:
            return [
                URLQueryItem(name: "client_id", value: StravaAPIConfig.ClientID),
                URLQueryItem(name: "redirect_uri", value: StravaAPIConfig.Redirect_URI),
                URLQueryItem(name: "response_type", value: "code"),
                URLQueryItem(name: "scope", value: StravaAPIConfig.Scope)
            ]
        case .token(let code):
            return [
                URLQueryItem(name: "client_id", value: StravaAPIConfig.ClientID),
                URLQueryItem(name: "client_secret", value: StravaAPIConfig.ClientSecret),
                URLQueryItem(name: "code", value: code ?? nil)
            ]
        }
    }
}

