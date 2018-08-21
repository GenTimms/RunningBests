//
//  Distance.swift
//  StravaBests
//
//  Created by Genevieve Timms on 22/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

enum Unit : String {
    case miles
    case km
    
    var pace: String {
        switch self {
        case .miles: return "/mi"
        case .km: return "/km"
        }
    }
    
    var meters: Double {
        switch self {
        case .miles: return Distance.oneMile.meters
        case .km: return Distance.oneKilometer.meters
        }
    }
}

enum Distance: String, Codable  {
    case fourHundredMeters = "400m"
    case halfMile = "1/2 mile"
    case oneKilometer = "1k"
    case oneMile = "1 mile"
    case twoMiles = "2 mile"
    case fiveKilometers = "5k"
    case tenKilometers = "10k"
    case halfMarathon = "Half-Marathon"
    case marathon = "Marathon"

    var meters: Double {
        switch self {
        case .fourHundredMeters: return 400
        case .halfMile: return 805
        case .oneKilometer: return 1000
        case .oneMile: return 1609
        case .twoMiles: return 3219
        case .fiveKilometers: return 5000
        case .tenKilometers: return 10000
        case .halfMarathon: return 21097.5
        case .marathon: return 42195
        }
    }
    
    static let All: [Distance] = [.fourHundredMeters, .halfMile, .oneKilometer, .oneMile, .twoMiles, .fiveKilometers, .tenKilometers, .halfMarathon, .marathon]
    
    static func all(upto max: Double) -> [Distance] {
        return Distance.All.filter{ $0.meters <= max }
    }

    var miles: Double {
        return meters / Distance.oneMile.meters
    }
    var km: Double {
        return meters / Distance.oneKilometer.meters
    }
}
