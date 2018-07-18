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
    
    var bests = [Distance: TimeInterval]()
    
        private enum CodingKeys: String, CodingKey {
            case name
            case distance
            case id
            case date = "start_date_local"
        }
    
//    mutating func addBests(from: [Distance: TimeInterval]) {
//        
//    }
    
//    init?(json: Data) {
//        let decoder = JSONDecoder()
//        decoder.dateDecodingStrategy  = .iso8601
//        if let newValue = try? decoder.decode(Run.self, from: json) {
//            self = newValue
//        } else {
//            return nil
//        }
//    }
    
//    init?(json: Data, using: JSONParser) {
//        if let newValue = try? JSONDecoder().decode(Run.self, from: json) {
//            self = newValue
//        } else {
//            return nil
//        }
//    }
    
    var json: Data?
    {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        encoder.dateEncodingStrategy = .iso8601
        return try? encoder.encode(self)
    }
    
   
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



