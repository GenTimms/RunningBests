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
    var bests: [Distance: Int]
    
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
        self.bests = [Distance: Int]()
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
    
    required init(from decoder: Decoder) throws {
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        date = try values.decode(Date.self, forKey: .date)
        distance = try values.decode(Double.self, forKey: .distance)
        
        var bestEfforts = try values.nestedUnkeyedContainer(forKey: .bests)
        var bestsDictionary = [Distance: Int]()
        
        while !bestEfforts.isAtEnd {
            let bestValues = try bestEfforts.nestedContainer(keyedBy: BestKeys.self)
            let distance = try bestValues.decode(Distance.self, forKey: .distance)
            let time = try bestValues.decode(Int.self, forKey: .time)
            bestsDictionary[distance] = time
        }
        bests = bestsDictionary
    }
}

extension Run {
    private enum CodingKeys: String, CodingKey {
        case name
        case distance
        case id
        case date = "start_date_local"
        case bests = "best_efforts"
    }
    
    private enum BestKeys: String, CodingKey {
        case distance = "name"
        case time = "elapsed_time"
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(date, forKey: .date)
        try container.encode(distance, forKey: .distance)
        
        var bestsEfforts = container.nestedUnkeyedContainer(forKey: .bests)
        for (distance, time) in bests {
            var bestsContainer = bestsEfforts.nestedContainer(keyedBy: BestKeys.self)
            try bestsContainer.encode(distance, forKey: .distance)
            try bestsContainer.encode(time, forKey: .time)
        }
    }
}
    
