//
//  RunBestsCellViewModel.swift
//  StravaBests
//
//  Created by Genevieve Timms on 19/08/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

struct RunBestsCellViewModel {
    let distance: String
    let pace: String
    let time: String
}

extension RunBestsCellViewModel {
    
    init(distance: String, pace: Int, time: Int) {
        self.distance = distance
        self.pace = DateComponentsFormatter.timeString(from: pace, zeroPadded: false) + Unit.miles.pace
        self.time = DateComponentsFormatter.timeString(from: time, zeroPadded: false)
    }
    
    init(distance: Distance, run: Run) {
        let time = run.bests[distance]!
        let pace = Distance.pace(time: time, meters: distance.meters, unit: .miles)
        let distanceString = distance == .twoMiles ? "2 miles" : distance.rawValue
        self.init(distance: distanceString, pace: pace, time: time)
    }
    
    init(run: Run) {
        let time = run.time
        let pace = Distance.pace(time: run.time, meters: run.distance, unit: .miles)
        self.init(distance: Distance.string(meters: run.distance, unit: .miles), pace: pace, time: time)
    }
}
