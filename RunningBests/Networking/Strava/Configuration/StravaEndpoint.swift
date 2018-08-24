//
//  StravaEndpoint.swift
//  StravaBests
//
//  Created by Genevieve Timms on 25/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

enum Strava {
    case activities()
    case activity(id: String)
    case authorize
    case token(code: String)
    case deauthorize(token: String)
}

extension Strava: Endpoint {
    
    var base: String {
        return "https://www.strava.com"
    }
    
    var path: String {
        switch self {
        case .activities: return "/api/v3/athlete/activities"
        case .activity(let id): return "/api/v3/activities/\(id)"
        case .authorize: return "/api/v3/oauth/authorize"
        case .deauthorize: return "/api/v3/oauth/deauthorize"
        case .token: return "/api/v3/oauth/token"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .activities():
            return [
                URLQueryItem(name: "before", value: nil),
                URLQueryItem(name: "after", value: nil),
                URLQueryItem(name: "per_page", value: String(200))
            ]
        case .activity: return []
        case .authorize:
            return [
                URLQueryItem(name: "client_id", value: StravaAuthConfig.ClientID),
                URLQueryItem(name: "redirect_uri", value: StravaAuthConfig.Redirect),
                URLQueryItem(name: "response_type", value: "code"),
                URLQueryItem(name: "scope", value: StravaAuthConfig.Scope)
            ]
        case .deauthorize(let token):
            return [
                URLQueryItem(name: "access_token", value: token)
            ]
        case .token(let code):
            return [
                URLQueryItem(name: "client_id", value: StravaAuthConfig.ClientID),
                URLQueryItem(name: "client_secret", value: StravaAuthConfig.ClientSecret),
                URLQueryItem(name: "code", value: code)
            ]
        }
    }
}

