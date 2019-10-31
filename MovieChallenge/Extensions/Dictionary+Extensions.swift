//
//  Dictionary.swift
//  MovieChallenge
//
//  Created by Lane Faison on 10/30/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import Foundation

extension Dictionary {
    public func JSON() -> Data {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: [])
            return jsonData
        } catch let error as NSError {
            print("JSON serialization failed with error: \(error)")
            return Data()
        }
    }
}
