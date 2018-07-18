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
                completion(Result.failure(JSONError.parseFailed))
                }
            }
        }
        task.resume()
    }
    
    
    func fetchRuns(completion: @escaping (Result<[Run]>) -> Void) {
        
        //TODO: Automatically Iterating until an empty page is returned?
        guard let accessToken = token, let request = Strava.activities().requestWithAuthorizationHeader(oauthToken: accessToken) else {
            completion(Result.failure(RequestError.invalidRequest))
            return
        }
        
        let task = jsonTask(request: request) { result in
            switch result {
            case .failure(let error): completion(Result.failure(error))
            case .success(let data):
                do {
                    let runs = try self.decodeRuns(from: data)
                    completion(Result.success(runs))
                } catch {
                    completion(Result.failure(JSONError.parseFailed))
                }
            }
        }
        task.resume()
        
    }
    
    //TODO Fetch Bests - Create new type best efforts? nested dictionary decode? coding keys?
    
    private func decodeRuns(from data: Data) throws -> [Run]  {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        //TODO: Filter for runs
        let runs = try decoder.decode([Run].self, from: data)
        return runs
    }
    
    private func getToken(from data: Data) throws -> String  {
        let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON
        guard let jsonData = json, let token = jsonData[Keys.token] as? String else {
            throw JSONError.parseFailed
        }
        self.token = token
        return token
    }
}


