//
//  StravaClient.swift
//  StravaBests
//
//  Created by Genevieve Timms on 05/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

class StavaClient: APIClient {

    var token: String?
    let service = "Strava"
    
    func fetchToken(accessCode: String, completion: @escaping (Result<String>) -> Void) {
        guard var request = Strava.token(code: accessCode).request else {
            completion(Result.failure(RequestError.invalidRequest))
            return
        }
        request.httpMethod = "POST"
        let task = jsonTask(request: request) { result in
            switch result {
            case .failure(let error): completion(Result.failure(error))
            case .success(let json): guard let token = json[Keys.token] as? String else {
                completion(Result.failure(JSONError.noValueForKey))
                return
            }
            self.token = token
            completion(Result.success(token))
            }
        }
        task.resume()
    }

    
    func fetchRuns(completion: @escaping (Result<[Run]>) -> Void) {
        guard let accessToken = token, var request = Strava.activities().request else {
            completion(Result.failure(RequestError.invalidRequest))
        }
        request.addValue(accessToken, forHTTPHeaderField: "Bearer")
        let task = jsonTask(request: request) { result in
            switch result {
                case .failure(let error): completion(Result.failure(error))
            case .success(let json): //use Strava Parser here?
            }
        }
        
        
    }
    
}


