//
//  APIAccount.swift
//  StravaBests
//
//  Created by Genevieve Timms on 29/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation
import Locksmith

typealias Service = String
typealias AccessCodeURL = URL

struct Keys {
    static let token = "token"
    static let expirationPeriod = "expirationPeriod"
    static let grantDate = "grantDate"
    static let serice = "service"
}

struct APIAccount {
    
    let service: String
    
    let accessToken: String
    let expiration: TimeInterval?
    let grantDate: Date
    
}

extension APIAccount {
    
    static func isAuthorized(for service: Service) -> Bool {
        if let _ = loadFromKeychain(service) {
            return true
        } else {
            return false
        }
    }
    
    func save() throws {
        //TODO: - Make expiration optional or remove altogether?
        try Locksmith.saveData(data: [Keys.token: accessToken, Keys.expirationPeriod: expiration, Keys.grantDate: grantDate.timeIntervalSince1970], forUserAccount: service)
    }
    
    static func loadFromKeychain(_ service: Service) -> APIAccount? {
        guard let dictionary = Locksmith.loadDataForUserAccount(userAccount: service), let token = dictionary[Keys.token] as? String, let expiration = dictionary[Keys.expirationPeriod] as? TimeInterval, let grantDateValue = dictionary[Keys.grantDate] as? TimeInterval else {
            return nil
        }
        
        let grantDate = Date(timeIntervalSince1970: grantDateValue)
        
        return APIAccount(service: service, accessToken: token, expiration: expiration, grantDate: grantDate)
    }
    
//    static func createAccount(from service: Service, with accessCodeURL: AccessCodeURL) -> APIAccount? {
////        if let query = accessCodeURL.  {
////
////        }
//        
//    }
}





