//
//  Authorization.swift
//  StravaBests
//
//  Created by Genevieve Timms on 25/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

//*******FAILES DUE TO STRAVA REQUIRED HTTP REDIRECT - SOLUTION REQUIRES BACKEND REDIRECT - OAUTH NOW HANDLED BY AUTHWEBVIEWCONTROLLER*******\\\\\
//TODO: Host a redirect?
//import Foundation
//import SafariServices
//
//class Authorization {
//
//    var authorizationURL: URL
//    var tokenURL: URL
//    var callback: String
//
//    var authSession: SFAuthenticationSession?
//
//    init(authorizationURL: URL, tokenURL: URL, callback: String) {
//        self.authorizationURL = authorizationURL
//        self.tokenURL = tokenURL
//        self.callback = callback
//    }
//
//
//    func getAuthToken(completion: @escaping (Result<String>) -> Void) {
//
//        getAccessCode { (result) in
//            switch result {
//            case .failure(let error): completion(.failure(error))
//            case .success(let queryItem):
//                if let url = self.tokenURL.addQuery(queryItem) {
//                    print("Access URL: \(url.absoluteString)")
//                    var request = URLRequest(url: url)
//                    request.httpMethod = "POST"
//                    let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
//                        print("Data: \(String(describing: data))")
//                        print("Response: \(String(describing: response))")
//                        print("Error: \(String(describing: error ?? nil))")
//                    })
//                    task.resume()
//                }
//            }
//
//        }
//    }
//
//
//    func getAccessCode(completion: @escaping (Result<URLQueryItem>) -> Void) {
//
//    self.authSession = SFAuthenticationSession.init(url: authorizationURL, callbackURLScheme: callback,
//                                                    completionHandler: { (callback:URL?, error:Error?) in
//
//                                                        guard error == nil,
//                                                            let successURL = callback,
//                                                            let codeQueryItem = successURL.getCodeQuery() else {
//
//                                                            completion(.failure(.sessionFailed(error)))
//                                                            return
//                                                        }
//
//                                                        completion(.success(codeQueryItem))
//    })
//
//
//    self.authSession?.start()
//}
//}
