//
//  StravaClient.swift
//  RunningBests
//
//  Created by Genevieve Timms on 05/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

class StravaClient: APIClient {

    let service = "Strava"
    
    var token: String?
    var oAuthRequest: URLRequest? {
        return Strava.authorize.request
    }
    
    //MARK: - Authorisation
    func fetchToken(accessCode: String, completion: @escaping (Result<String>) -> Void) {
        guard let request = Strava.token(code: accessCode).postRequest else {
            completion(Result.failure(RequestError.invalidRequest))
            return
        }
        fetch(with: request, parse: getToken, completion: completion)
    }
    
    func deauthorize(completion: @escaping (Result<String>) -> Void) {
        
        guard let accessToken = token, let request = Strava.deauthorize(token: accessToken).postRequest else {
            completion(Result.failure(RequestError.invalidRequest))
            return
        }
        
        self.token = nil
        fetch(with: request, parse: getToken, completion: completion)
    }
    
    private func getToken(from data: Data) -> String? {
        if let token = data.getJSONValue(for: Keys.token) {
            self.token = token
            return token
        } else {
            return nil
        }
    }

    //MARK: - Fetch Runs
    func fetchRuns(completion: @escaping (Result<Runs>) -> Void) {
        fetchPartialRuns() { result in
            switch result {
            case.success(let partialRuns):
                guard !partialRuns.isEmpty else { completion(Result.failure(RequestError.dataEmpty)); return }
                self.getBests(for: partialRuns, completion: completion)
            case.failure(let error): completion(Result.failure(error))
            }
        }
    }
    
    private func fetchPartialRuns(completion: @escaping (Result<[Run]>) -> Void) {
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
    
    //MARK: Fetch Bests - Operations
    static let errorMargin = 0.05 //5%
    var runFetchingErrors = [(String, Error)]()
    
    private func getBests(for runs: [Run], completion: @escaping (Result<Runs>) -> Void) {
        runFetchingErrors.removeAll()
        let queue = OperationQueue()
        let operations = runs.map { StravaRunDetailsOperation(run: $0, client: self) }
        
        DispatchQueue.global(qos: .userInitiated).async {
            queue.addOperations(operations, waitUntilFinished: true)
            DispatchQueue.main.async {
                guard self.runFetchingErrors.count <= Int(round(Double(runs.count) * StravaClient.errorMargin)) else {
                    completion(Result.failure(OperationError.fetchingErrors(self.runFetchingErrors)))
                    return
                }
                completion(Result.success(Runs(with: runs)))
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
}
