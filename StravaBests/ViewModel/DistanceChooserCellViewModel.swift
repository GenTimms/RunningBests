//
//  DistanceCellViewModel.swift
//  StravaBests
//
//  Created by Genevieve Timms on 02/08/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

struct DistanceChooserCellViewModel {
    let distance: String
    let bestTime: String
}

extension DistanceChooserCellViewModel {
    init(distance: Distance, bestRun: Run?) {
        self.distance = distance.rawValue
        if let run = bestRun {
            self.bestTime = DateComponentsFormatter.timeString(from: run.bests[distance]!, zeroPadded: true)
        } else {
            self.bestTime = ""
        }
    }
}

