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
    
    typealias key = String
    
    func addQuery(_ item : URLQueryItem) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems?.append(item)
        return components?.url
    }
    
    func getQueryValue(for key: key) -> String? {
        let components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        if let codeQuery = components?.queryItems?.filter({$0.name == key}).first {
            return codeQuery.value
        }
        return nil
    }
    
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
extension DateFormatter {
    static func dateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy"
        return formatter.string(from: date)
    }
    
    static func timeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}

extension DateComponentsFormatter {
    static func timeString(from seconds: Int) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = [.pad]
        return formatter.string(from: Double(seconds)) ?? ""
    }
}

