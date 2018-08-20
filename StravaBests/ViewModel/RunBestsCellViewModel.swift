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
    init(distance: Distance, run: Run) {
        let time = run.bests[distance]!
        let pace = distance.pace(for: time, unit: .miles)
        self.distance = distance.rawValue
        self.pace = DateComponentsFormatter.timeString(from: pace, zeroPadded: false) + Unit.miles.rawValue
        self.time = DateComponentsFormatter.timeString(from: time, zeroPadded: false)
    }
}
