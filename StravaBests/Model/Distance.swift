//
//  Distance.swift
//  StravaBests
//
//  Created by Genevieve Timms on 22/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

enum Distance : String, Codable {
    case oneMile
    case twoMiles
    case fiveKilometers
    case tenKilometers
    case halfMarathon
    case marathon

   //TODO: Swift 4.2 CaseIterable - adds variable all cases
    static let All: [Distance] = [.oneMile, .twoMiles, .fiveKilometers, .tenKilometers, .halfMarathon, .marathon]
}



