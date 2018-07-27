//
//  Runs.swift
//  StravaBests
//
//  Created by Genevieve Timms on 27/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

struct Runs {
    
    let runs: [Run]
    
    init(with runs: [Run]) {
        self.runs = runs
    }
    
    func getBests(with client: APIClient, completion: @escaping () -> Void) {
        let queue = OperationQueue()
        guard let stravaClient = client as? StravaClient else {
            print("could not get bests, wrong API Client")
            return //TODO: Error notification
        }
        let operations = runs.map {StravaRunDetailsOperation(run: $0, client: stravaClient)}
        
        DispatchQueue.global().async {
            queue.addOperations(operations, waitUntilFinished: true)
            DispatchQueue.main.async(execute: completion)
        }
    }
    
    
//    func getRunsWithBests(for distance: Distance) -> [Run] {
//        return runs.filter(<#T##isIncluded: (Run) throws -> Bool##(Run) throws -> Bool#>)
//    }
    
    
}
