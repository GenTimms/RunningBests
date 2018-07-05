//
//  APIAccount.swift
//  StravaBests
//
//  Created by Genevieve Timms on 29/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation
import Locksmith


struct Keys {
    static let token = "token"
    static let service = "service"
}

typealias Service = String

struct APIAccount {
    
    let service: String
    let accessToken: String
    //what does strava token return do we need all these variables?
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
        //TODO: - Make expiration optional or remove altogether? see what you get back
        try Locksmith.saveData(data: [Keys.token: accessToken, Keys.expirationPeriod: expiration, Keys.grantDate: grantDate.timeIntervalSince1970], forUserAccount: service)
    }
    
    func delete() throws {
        try Locksmith.deleteDataForUserAccount(userAccount: service)
    }
    
    static func loadFromKeychain(_ service: Service) -> APIAccount? {
        guard let dictionary = Locksmith.loadDataForUserAccount(userAccount: service), let token = dictionary[Keys.token] as? String, let expiration = dictionary[Keys.expirationPeriod] as? TimeInterval, let grantDateValue = dictionary[Keys.grantDate] as? TimeInterval else {
            return nil
        }
        
        let grantDate = Date(timeIntervalSince1970: grantDateValue)
        
        return APIAccount(service: service, accessToken: token, expiration: expiration, grantDate: grantDate)
    }
    

}





