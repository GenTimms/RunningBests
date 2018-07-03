//
//  utilityExtensions.swift
//  StravaBests
//
//  Created by Genevieve Timms on 25/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation
import UIKit

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
    
    //getexpiration
    //geterror
    
    
    func begins(with string: String) -> Bool {
        let start = self.absoluteString.components(separatedBy: "/?")
        return start[0] == string
    }
    
}
    
extension UIViewController {
    var contents: UIViewController {
        if let navcon = self as? UINavigationController {
            return navcon.visibleViewController ?? navcon
        } else {
            return self
        }
    }
}
