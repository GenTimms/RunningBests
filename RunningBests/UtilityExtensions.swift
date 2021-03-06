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

extension Data {
    
    func getJSONValue(for key: String) -> String? {
        do {
            let json = try JSONSerialization.jsonObject(with: self, options: []) as? [String: AnyObject]
            guard let jsonData = json, let value = jsonData[key] as? String else {
                throw JSONError.parseFailed
            }
            return  value
        }
        catch {
            return nil
        }
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
    
    static func dateAndTimeString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yy  HH:mm"
        return formatter.string(from: date)
    }
}

extension DateComponentsFormatter {
    static func timeString(from seconds: Int, zeroPadded: Bool) -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        
        if zeroPadded {
            formatter.zeroFormattingBehavior = [.pad]
        } else {
            formatter.zeroFormattingBehavior = [.dropLeading]
        }
        return formatter.string(from: Double(seconds)) ?? ""
    }
}

extension Distance {
    static func string(meters: Double, unit: Unit) -> String {
        return String(format: "%.1f", meters/unit.meters) + " " + unit.rawValue
    }
    
    static func pace(time: Int, meters: Double, unit: Unit) -> Int {
        return Int(Double(time) / (meters/unit.meters))
    }
}
