//
//  StravaClient.swift
//  StravaBests
//
//  Created by Genevieve Timms on 05/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

class StavaClient: APIClient {
    
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
            case .success(let json): guard let token = json[URLKeys.token] as? String else {
                completion(Result.failure(JSONError.noValueForKey))
                return
            }
            completion(Result.success(token))
            }
        }
        task.resume()
    }
}


