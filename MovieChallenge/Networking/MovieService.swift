//
//  MovieService.swift
//  MovieChallenge
//
//  Created by Lane Faison on 10/30/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import Foundation

public typealias JSON = [String: Any]

public enum Category: String {
    case popular
    case topRated = "top_rated"
    case upcoming
}

final class MovieService {
    
    private static var infoDictionary: [String: Any]? {
        return Bundle.main.infoDictionary
    }
    
    private static var apiKey: String {
        return infoDictionary?["Movie_DB_API_Key"] as? String ?? ""
    }
    
    private static var baseUrl: String {
        return "https://api.themoviedb.org/3/movie/"
    }
    
    static var imageBaseUrl: String {
        return "https://image.tmdb.org/t/p/w154"
    }
    
    static func fetchMoviesByCategory(_ category: Category, completion: ((Movies?, Error?) -> Void)?) {
        guard let url = URL(string: "\(baseUrl)\(category.rawValue)?page=1&language=en-US&api_key=\(apiKey)") else { return }
        
        makeGetRequest(withURL: url) { (json, error) in
            if error != nil {
                completion?(nil, error)
            } else if let json = json {
                let movies = Movies(json: json)
                completion?(movies, nil)
            }
        }
    }
}

// MARK: - Network Helpers
extension MovieService {
    
    static func makeGetRequest(withURL url: URL, completion: ((JSON?, Error?) -> Void)?) {
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                completion?(nil, error)
            } else if let response = response as? HTTPURLResponse {
                if response.statusCode == 200, let data = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON {
                            completion?(json, nil)
                        }
                    } catch let error {
                        completion?(nil, error)
                    }
                } else {
                    print("Something went wrong. Received a response code of \(response.statusCode).")
                    completion?(nil, nil)
                }
            }
        })
        dataTask.resume()
    }
}
