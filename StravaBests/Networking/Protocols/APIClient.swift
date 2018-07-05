//
//  APIClient.swift
//  StravaBests
//
//  Created by Genevieve Timms on 05/07/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

protocol APIClient {
    
  var service: String { get }
    
  func fetchToken(accessCode: String, completion: @escaping (Result<String>) -> Void)
    

}

extension APIClient {
    //fetch(request: URLRequest, completion: Result)
}
