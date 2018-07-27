//
//  Best.swift
//  StravaBests
//
//  Created by Genevieve Timms on 20/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

struct Best: Codable {
    
    let distance: Distance
    let time: Int
    
    private enum CodingKeys: String, CodingKey {
        case distance = "name"
        case time = "elapsed_time"
    }
}
