//
//  Distance.swift
//  StravaBests
//
//  Created by Genevieve Timms on 22/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

enum Distance : Double  {
    case oneMile = 1
    case twoMiles = 2
    case fiveKilometers = 3.107
    case tenKilometers = 6.214
    case halfMarathon = 13.109
    case marathon = 26.219
    
   //TODO: Swift 4.2 CaseIterable - adds variable all cases
    static let All: [Distance] = [.oneMile, .twoMiles, .fiveKilometers, .tenKilometers, .halfMarathon, .marathon]
}



