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
    typealias JSON = [String: AnyObject]
    
    func fetchToken(accessCode: String, completion: @escaping (Result<String>) -> Void) {
        guard var request = Strava.token(code: accessCode).request else {
            completion(Result.failure(RequestError.invalidRequest))
            return
        }
        request.httpMethod = "POST"
        let task = jsonTask(request: request) { result in
            switch result {
            case .failure(let error): completion(Result.failure(error))
            case .success(let data):  do {
                let token = try self.getToken(from: data)
                completion(Result.success(token))
            } catch {
                completion(Result.failure(error))
                }
            }
        }
        task.resume()
    }
    
    private func getToken(from data: Data) throws -> String  {
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON
        guard let jsonData = json, let token = jsonData[Keys.token] as? String else {
            throw JSONError.parseFailed
        }
        self.token = token
        return token
    }
    
    func fetchActivities(completion: @escaping (Result<[Activity]>) -> Void) {
        //TODO: Automatically Iterating until an empty page is returned
        guard let accessToken = token, let request = Strava.activities().requestWithAuthorizationHeader(oauthToken: accessToken) else {
            completion(Result.failure(RequestError.invalidRequest))
            return
        }
        
        let task = jsonTask(request: request) { result in
            switch result {
            case .failure(let error): completion(Result.failure(error))
            case .success(let data):
                do {
                    let activities = try Activity.decodeActivities(from: data)
                    completion(Result.success(activities))
                } catch {
                    completion(Result.failure(error))
                }
            }
        }
        task.resume()
    }
    
    func fetchRun(for activity: Activity, completion: @escaping (Result<Run>) -> Void) {
        guard let accessToken = token, let request = Strava.activity(id: String(activity.id)).requestWithAuthorizationHeader(oauthToken: accessToken) else {
            completion(Result.failure(RequestError.invalidRequest))
            return
        }
        
        let task = jsonTask(request: request) { result in
            switch result {
            case .failure(let error): completion(Result.failure(error))
            case .success(let data):
                do {
                 let run = try Run(json: data)
                 completion(Result.success(run))
                }
                catch {
                 completion(Result.failure(error))
                }
            }
        }
        task.resume()
    }
}


