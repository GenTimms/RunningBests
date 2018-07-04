//
//  Errors.swift
//  StravaBests
//
//  Created by Genevieve Timms on 25/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

enum AuthError: Error {
    case cancelled
    case requestNil
    case redirectNil
    case callbackURLAuthCode
    case navigation(String)
    case sessionFailed(Error)
}
