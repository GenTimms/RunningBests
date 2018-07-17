//
//  ActivityParser.swift
//  StravaBests
//
//  Created by Genevieve Timms on 24/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

extension DateFormatter {
    func date(fromStravaString dateString: String) -> Date? {
        self.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return self.date(from: dateString)
    }
}

extension Run {
    init?(stravaJSON: [String : Any]) {
        guard let id = stravaJSON["id"] as? String,
        let name = stravaJSON["name"] as? String,
        let dateString = stravaJSON["start_date_local"] as? String,
        let date = DateFormatter().date(fromStravaString: dateString),
        let distance = stravaJSON["distance"] as? Int else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.date = date
        self.distance = distance
    }
    
    
}

   enum CodingKeys: String, CodingKey {
        case name
        case distance
        case id
        case date = "start_date_local"
    }

struct StravaParser : JSONParser {    
    typealias codingKeysEnum = CodingKeys
//    func parse<Run>(data: Data) -> [Run] {
//
//    }
    
}


//extension Run {
//
//    private enum CodingKeys: String, CodingKey {
//        case name
//        case distance
//        case id
//        case date = "start_date_local"
//    }
//
//    func encode(to encoder: Encoder) throws {
////        var container = encoder.container(keyedBy: CodingKeys.self)
////        try container.encoder(someDate, forKey: .someDate)
//    }
//
//    init(from decoder: Decoder) throws {
////        let container = try decoder.container(keyedBy: CodingKeys.self)
////        someDate =  try container.decode(Date.self, forKey: .someDate)
////
////        decode your superclass too (with their decoder)
////        let superDecoder = try container.superDecoder()
////        try super.init(from: superDecoder)
//
////        let values = try decoder.container(keyedBy: CodingKeys.self)
////        latitude = try values.decode(Double.self, forKey: .latitude)
////        longitude = try values.decode(Double.self, forKey: .longitude)
////
////        let additionalInfo = try values.nestedContainer(keyedBy: AdditionalInfoKeys.self, forKey: .additionalInfo)
////        elevation = try additionalInfo.decode(Double.self, forKey: .elevation)
//
//    }
