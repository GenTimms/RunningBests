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
    
    func fetchToken(accessCode: String, completion: @escaping (Result<String>) -> Void)
    
}

extension APIClient {
    
    func jsonTask(request: URLRequest, completion: @escaping (Result<Data>) -> Void) -> URLSessionDataTask {
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
            completion(Result.success(data))
        }
        return task
    }
}

