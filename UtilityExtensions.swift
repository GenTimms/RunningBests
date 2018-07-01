//
//  utilityExtensions.swift
//  StravaBests
//
//  Created by Genevieve Timms on 25/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

extension URL {
    
    func addQuery(_ item : URLQueryItem) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems?.append(item)
        return components?.url
    }
    
    func getCodeQuery() -> URLQueryItem? {
        let components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        return components?.queryItems?.filter({$0.name == "code"}).first
    }
    
    func contains(string: String) -> Bool {
        return self.absoluteString.contains(string)
    }
}
