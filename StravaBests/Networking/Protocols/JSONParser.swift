//
//  JSONParser.swift
//  StravaBests
//
//  Created by Genevieve Timms on 24/06/2018.
//  Copyright © 2018 GMJT. All rights reserved.
//

import Foundation

protocol JSONParser {
    associatedtype codingKeysEnum: CodingKey
    //func parse<T: Decodable>(data: Data) -> T
}

extension JSONParser {
    var codingKeys: codingKeysEnum.Type {
        return codingKeysEnum.self
    }
}
