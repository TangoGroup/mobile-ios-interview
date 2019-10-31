//
//  Movie.swift
//  MovieChallenge
//
//  Created by Lane Faison on 10/30/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

public struct Movies: Decodable {
    public let content: [Movie]
    
    enum CodingKeys: String, CodingKey {
        case content = "results"
    }
    
    public init?(json: JSON) {
        do {
            self = try JSONDecoder().decode(Movies.self, from: json.JSON())
        } catch {
            assertionFailure("Failed to decode Movies. \(error)")
            return nil
        }
    }
}

public struct Movie: Decodable {
    private let posterUrl: String?
    public let overview: String
    public let title: String
    public let popularity: Double
    public let voteCount: Int
    public let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case posterUrl = "poster_path"
        case overview
        case title
        case popularity
        case voteCount = "vote_count"
        case voteAverage = "vote_average"
    }
    
    public var posterImageUrl: URL? {
        guard let posterUrl = posterUrl else { return nil }
        
        return URL(string: "\(MovieService.imageBaseUrl)\(posterUrl)")
    }
    
    public init?(json: JSON) {
        do {
            self = try JSONDecoder().decode(Movie.self, from: json.JSON())
        } catch {
            assertionFailure("Failed to decode Movie. \(error)")
            return nil
        }
    }
}
