//
//  APIClient.swift
//  StravaBests
//
//  Created by Genevieve Timms on 05/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

protocol APIClient {
    
    var token: String? {get set}
    var service: String { get }
    
    func fetchToken(completion: @escaping (Result<String>) -> Void)
    
}

extension APIClient {
    
    typealias JSON = [String: AnyObject]
    
    func jsonTask(request: URLRequest, completion: @escaping (Result<JSON>) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: request) { (data, response , error) in
            
            if let fetchError = error {
                completion(Result.failure(RequestError.errorReturned(fetchError)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(Result.failure(RequestError.invalidResponse))
                return
            }
            guard httpResponse.statusCode == 200 else {
                completion(Result.failure(RequestError.responseStatusCode(httpResponse.statusCode)))
                return
            }
            guard let data = data else {
                completion(Result.failure(RequestError.dataNil))
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON
                if let jsonData = json {
                    completion(Result.success(jsonData))
                }
            } catch {
                completion(Result.failure(JSONError.parseFailed))
                return
            }
        }
        return task
    }
}

