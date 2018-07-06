//
//  Errors.swift
//  StravaBests
//
//  Created by Genevieve Timms on 25/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

enum AuthWebViewError: Error {
    case cancelled
    case requestNil
    case redirectNil
    case callbackURLAuthCode
    case navigation(String)
    case sessionFailed(Error)
}

enum RequestError: Error {
    case responseStatusCode(Int)
    case errorReturned(Error)
    case invalidResponse
    case dataNil
    case invalidRequest
}

enum JSONError: Error {
    case parseFailed
    case noValueForKey
}

