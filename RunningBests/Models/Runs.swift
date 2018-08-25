//
//  Runs.swift
//  StravaBests
//
//  Created by Genevieve Timms on 27/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

struct Runs {
    
    let all: [Run]
    
    init(with runs: [Run]) {
        self.all = runs
    }
    
    var maxDistance: Double {
        return all.map{$0.distance}.max() ?? 0.0
    }
    
    func withBests(for distance: Distance) -> [Run] {
        return all.filter{$0.bests[distance] != nil}
    }
    
    func best(for distance: Distance) -> Run? {
        let runs = withBests(for: distance)
        return runs.min(by: { $0.bests[distance]! < $1.bests[distance]!})
    }
}
