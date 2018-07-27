//
//  Run.swift
//  StravaBests
//
//  Created by Genevieve Timms on 22/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

class Run: Codable {
    
    //Activity Data
    let id: Int
    let name: String
    let date: Date
    let distance: Double
    
    //Detailed Run Data
    var bests: [Best]
    
        private enum CodingKeys: String, CodingKey {
            case name
            case distance
            case id
            case date = "start_date_local"
            case bests = "best_efforts"
        }
    
    init(run: Run) {
        self.id = run.id
        self.name = run.name
        self.date = run.date
        self.distance = run.distance
        self.bests = run.bests
    }
    
    init(activity: Activity) {
        self.id = activity.id
        self.name = activity.name
        self.date = activity.date
        self.distance = activity.distance
        self.bests = [Best]()
    }
    
    convenience init(json: Data) throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy  = .iso8601
        self.init(run: try decoder.decode(Run.self, from: json))
    }
    
    var json: Data?
    {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        return try? encoder.encode(self)
    }
}
