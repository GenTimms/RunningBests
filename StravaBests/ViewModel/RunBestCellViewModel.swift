//
//  BestsCellViewModel.swift
//  StravaBests
//
//  Created by Genevieve Timms on 02/08/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

struct RunBestCellViewModel {
    let runName: String
    let runDate: String
    let runTime: String
    let distanceBest: String
}

extension RunBestCellViewModel {
    init(distance: Distance, run: Run) {
        self.runName = run.name
        self.runDate = DateFormatter.dateString(from: run.date)
        self.runTime = DateFormatter.timeString(from: run.date)
        self.distanceBest = DateComponentsFormatter.timeString(from: run.bests[distance]!)
    }
}
