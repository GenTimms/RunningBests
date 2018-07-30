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
    
    func withBests(for distance: Distance) -> [Run] {
        return all.filter{$0.bests.contains{$0.distance == distance}}
    }
    
    var maxDistance: Double {
        return all.map{$0.distance}.max() ?? 0.0
    }
}
