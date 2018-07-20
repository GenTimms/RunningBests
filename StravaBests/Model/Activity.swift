//
//  Activity.swift
//  StravaBests
//
//  Created by Genevieve Timms on 19/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

struct Activity: Codable {
    
    let id: Int
    let name: String
    let date: Date
    let distance: Double
    let type: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case distance
        case id
        case date = "start_date_local"
        case type
    }
    
    static func decodeActivities(from data: Data) throws -> [Activity]  {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let activities = try decoder.decode([Activity].self, from: data)
        return activities
    }
}



