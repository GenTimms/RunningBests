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

    var urlComponents: URLComponents? {
        guard var components = URLComponents(string: base) else {
            return nil
        }
        components.path = path
        components.queryItems = queryItems
        return components
    }

    var request: URLRequest? {
        guard let url = urlComponents?.url else {
            return nil
        }
        return URLRequest(url: url)
    }
    
    var postRequest: URLRequest? {
        guard var postRequest = request else {
            return nil
        }
        postRequest.httpMethod = "POST"
        return postRequest
    }
    
    func requestWithAuthorizationHeader(oauthToken: String) -> URLRequest? {
        guard var oauthRequest = request else {
            return nil
        }
        oauthRequest.addValue("Bearer \(oauthToken)", forHTTPHeaderField: "Authorization")
        return oauthRequest
    }
    
    var url: URL? {
        return urlComponents?.url ?? nil
    }
}

