//
//  StravaClient.swift
//  StravaBests
//
//  Created by Genevieve Timms on 05/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

class StravaClient: APIClient {
    
    typealias JSON = [String: AnyObject]
    let service = "Strava"
    
    var token: String?
    var oAuthRequest: URLRequest? {
        return Strava.authorize.request
    }
    
  func fetchToken(accessCode: String, completion: @escaping (Result<String>) -> Void) {
    
        guard let request = Strava.token(code: accessCode).postRequest else {
            completion(Result.failure(RequestError.invalidRequest))
            return
        }
        fetch(with: request, parse: getToken, completion: completion)
    }

    private func getToken(from data: Data) -> String?  {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON
            guard let jsonData = json, let token = jsonData[Keys.token] as? String else {
                throw JSONError.parseFailed
            }
            self.token = token
            return token
        }
        catch {
            return nil
        }
    }
    
    func fetchRunList(completion: @escaping (Result<[Activity]>) -> Void) {
        //TODO: Automatically Iterating until an empty page is returned?
        guard let accessToken = token, let request = Strava.activities().requestWithAuthorizationHeader(oauthToken: accessToken) else {
            completion(Result.failure(RequestError.invalidRequest))
            return
        }
        
        fetch(with: request, parse: { (data) -> [Activity]? in
            return try? Activity.decodeActivities(from: data).filter{$0.type == "Run"}
        }, completion: completion)
    }

    func fetchRunDetails(for run: Run, completion: @escaping (Result<Run>) -> Void) {
        guard let accessToken = token, let request = Strava.activity(id: String(run.id)).requestWithAuthorizationHeader(oauthToken: accessToken) else {
            completion(Result.failure(RequestError.invalidRequest))
            return
        }
        
        fetch(with: request, parse: { (data) -> Run? in
            return try? Run(json: data)
        }, completion: completion)
    }
}
