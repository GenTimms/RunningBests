//
//  Distance.swift
//  StravaBests
//
//  Created by Genevieve Timms on 22/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

enum Distance : String, Codable {
    case oneMile = "1 mile"
    case twoMiles = "2 mile"
    case fiveKilometers = "5k"
    case tenKilometers = "10k"
    case halfMarathon = "Half-Marathon"
    case marathon = "Marathon"

   //TODO: Swift 4.2 CaseIterable - adds variable all cases
    static let All: [Distance] = [.oneMile, .twoMiles, .fiveKilometers, .tenKilometers, .halfMarathon, .marathon]
}



