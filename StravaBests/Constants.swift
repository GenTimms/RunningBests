//
//  Constants.swift
//  StravaBests
//
//  Created by Genevieve Timms on 01/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

struct Segues {
    static var AuthSegue = "present authwebview"
    static var AuthUnwind = "unwindWithAuthResult"
    static var DistanceChooserSegue = "Show Distance Chooser"
    static var Bests = "Show Bests"
    static var runBests = "Show Run Bests"
}

struct URLKeys {
    static var redirect = "redirect_uri"
    static var code = "code"
    static var token = "access_token"
}

struct Cells {
    static var distance = "Distance Cell"
    static var distanceRunBest = "Distance Run Best Cell"
    static var runBest = "Run Best Cell"
}
