//
//  MovieListViewModel.swift
//  MovieChallenge
//
//  Created by Lane Faison on 10/30/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import Foundation

protocol MovieListDelegate: class {
    func moviesReceived()
}

final class MovieListViewModel {
    
    weak var delegate: MovieListDelegate?
    
    var movieData: [MovieSection] = []
    
    var categories: [Category] = [.popular, .topRated, .upcoming]
    
    func fetchMovies() {
        let group = DispatchGroup()
        
        for category in categories {
            group.enter()
            MovieService.fetchMoviesByCategory(category) { [weak self] (movies, error) in
                guard let self = self else { return }
                
                defer { group.leave() }
                
                if error != nil {
                    // Handle error with an Alert
                } else if let movies = movies {
                    let genreLibrary = MovieSection(type: category, movies: movies)
                    self.movieData.append(genreLibrary)
                }
            }
        }
        
        group.notify(queue: .main) {
            self.delegate?.moviesReceived()
        }
    }
}
