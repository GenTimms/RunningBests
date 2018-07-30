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
    
    func fetchRuns(completion: @escaping (Result<Runs>) -> Void) {
        fetchPartialRuns() { result in
            switch result {
            case.success(let partialRuns): guard !partialRuns.isEmpty else { completion(Result.failure(RequestError.dataEmpty)); return }
            self.getBests(for: partialRuns, completion: completion)
            case.failure(let error): completion(Result.failure(error))
            }
        }
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
    
    static let errorMargin = 0.05 //5%
    var runFetchingErrors = [(String, Error)]()
    
    private func getBests(for runs: [Run], completion: @escaping (Result<Runs>) -> Void) {
        
        let queue = OperationQueue()
        let operations = runs.map { StravaRunDetailsOperation(run: $0, client: self) }
        
        DispatchQueue.global(qos: .userInitiated).async {
            queue.addOperations(operations, waitUntilFinished: true)
            DispatchQueue.main.async {
                for error in self.runFetchingErrors {
                    print("Fetching Error: \(error.0 + error.1.localizedDescription)")
                }
                guard self.runFetchingErrors.count < Int(round(Double(runs.count) * StravaClient.errorMargin)) else {
                    completion(Result.failure(OperationError.fetchingErrors(self.runFetchingErrors)))
                    return
                }
                    completion(Result.success(Runs(with: runs)))
            }
        }
    }
    
    private func fetchPartialRuns(completion: @escaping (Result<[Run]>) -> Void) {
        //TODO: Automatically Iterating until an empty page is returned or limit reached
        guard let accessToken = token, let request = Strava.activities().requestWithAuthorizationHeader(oauthToken: accessToken) else {
            completion(Result.failure(RequestError.invalidRequest))
            return
        }
        
        fetch(with: request, parse: { (data) -> [Run]? in
            if let activities = try? Activity.decodeActivities(from: data).filter{$0.type == "Run"} {
                return activities.map{Run(activity: $0)}
            } else {
                return nil
            }
        }, completion: completion)
    }
}
