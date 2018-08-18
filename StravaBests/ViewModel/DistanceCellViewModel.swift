//
//  DistanceCellViewModel.swift
//  StravaBests
//
//  Created by Genevieve Timms on 02/08/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

struct DistanceCellViewModel {
    let distance: String
    let bestTime: String
    let bestName: String
    let bestDate: String
}

extension DistanceCellViewModel {
    init(distance: Distance, bestRun: Run?) {
        self.distance = distance.rawValue
        if let run = bestRun {
            self.bestTime = "Best: " + DateComponentsFormatter.timeString(from: run.bests[distance]!)
            self.bestName = run.name
            self.bestDate = DateFormatter.dateString(from: run.date)
        } else {
            self.bestTime = ""
            self.bestName = ""
            self.bestDate = ""
        }
    }
}

