//
//  Endpoint.swift
//  StravaBests
//
//  Created by Genevieve Timms on 25/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

protocol Endpoint {
   
    var base: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {

    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
        return components
    }

    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
    
    func requestWithAuthorizationHeader(oauthToken: String) -> URLRequest {
        var oauthRequest = request
        oauthRequest.addValue("Bearer \(oauthToken)", forHTTPHeaderField: "Authorization")
        return oauthRequest
    }
}

