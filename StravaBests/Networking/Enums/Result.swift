//
//  Result.swift
//  StravaBests
//
//  Created by Genevieve Timms on 25/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}
