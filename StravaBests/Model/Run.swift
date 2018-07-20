//
//  Run.swift
//  StravaBests
//
//  Created by Genevieve Timms on 22/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

struct Run: Codable {
    
    let id: Int
    let name: String
    let date: Date
    let distance: Double
    
    let bests: [Best]
    
        private enum CodingKeys: String, CodingKey {
            case name
            case distance
            case id
            case date = "start_date_local"
            case bests = "best_efforts"
        }
    
    init(json: Data) throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy  = .iso8601
        self = try decoder.decode(Run.self, from: json)
    }
    
    var json: Data?
    {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        return try? encoder.encode(self)
    }
}
