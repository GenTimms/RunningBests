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
    
    //create standard json task in protocol extension to prevent repeated code then wrap with this method?
    //protocol extension returns json returns json task? 
    func fetchToken(accessCode: String, completion: @escaping (Result<String>) -> Void) {
        if var request = Strava.token(code: accessCode).request {
            request.httpMethod = "POST"
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    
                    if let fetchError = error {
                        completion(Result.failure(RequestError.errorReturned(fetchError)))
                        return
                    }
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(Result.failure(RequestError.invalidResponse))
                        return
                    }
                    guard httpResponse.statusCode !=  200 else {
                        completion(Result.failure(RequestError.responseStatusCode(httpResponse.statusCode)))
                        return
                    }
                    guard let tokenData = data else {
                        completion(Result.failure(RequestError.dataNil))
                        return
                    }
                    guard let tokenJSON = try? JSONSerialization.jsonObject(with: tokenData, options: []) as? [String: AnyObject] else {
                        completion(Result.failure(JSONError.parseFailed))
                        return
                    }
                    guard let token = tokenJSON?["access_token"] as? String else {
                        completion(Result.failure(JSONError.noValueForKey))
                        return
                    }
                    
                    completion(Result.success(token))
                }
            }
        }
    }
}
