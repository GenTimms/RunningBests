//
//  Distance.swift
//  StravaBests
//
//  Created by Genevieve Timms on 22/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

enum Distance : String, Codable {
    case fourHundredMeters = "400m"
    case halfMile = "1/2 mile"
    case oneKilometer = "1k"
    case oneMile = "1 mile"
    case twoMiles = "2 mile"
    case fiveKilometers = "5k"
    case tenKilometers = "10k"
    case halfMarathon = "Half-Marathon"
    case marathon = "Marathon"
    
    static let Meters: [Distance:Double] = [.fourHundredMeters: 400, .halfMile: 805, .oneKilometer: 1000, .oneMile: 1609, .twoMiles: 3219, .fiveKilometers: 5000, .tenKilometers: 10000, .halfMarathon: 21097.5, .marathon: 42195]

    static let All: [Distance] = [.fourHundredMeters, .halfMile, .oneKilometer, .oneMile, .twoMiles, .fiveKilometers, .tenKilometers, .halfMarathon, .marathon]
    
    static func all(upto max: Double) -> [Distance] {
        return Distance.All.filter{ Distance.Meters[$0]! <= max }
    }
}
