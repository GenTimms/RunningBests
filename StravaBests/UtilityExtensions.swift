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
        let components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems?.append(item)
        return components?.url
    }
    
    func getCodeQuery() -> URLQueryItem? {
        let components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        return components?.queryItems?.filter({$0.name == "code"}).first
    }
}
