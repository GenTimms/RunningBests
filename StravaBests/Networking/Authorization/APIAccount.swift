//
//  APIAccount.swift
//  StravaBests
//
//  Created by Genevieve Timms on 29/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation
import Locksmith

fileprivate struct Keys {
    static let token = "token"
    static let service = "service"
}

typealias Service = String

struct APIAccount {
    let service: String
    let accessToken: String
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
        try Locksmith.saveData(data: [Keys.token: accessToken], forUserAccount: service)
    }
    
    func delete() throws {
        try Locksmith.deleteDataForUserAccount(userAccount: service)
    }
    
    static func loadFromKeychain(_ service: Service) -> APIAccount? {
        guard let dictionary = Locksmith.loadDataForUserAccount(userAccount: service), let token = dictionary[Keys.token] as? String else {
            return nil
        }
        
        return APIAccount(service: service, accessToken: token)
    }
}





