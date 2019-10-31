//
//  MovieListViewController.swift
//  MovieChallenge
//
//  Created by Lane Faison on 10/30/19.
//  Copyright © 2019 Lane Faison. All rights reserved.
//

import UIKit

final class MovieListViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(BasicMovieTableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private let viewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
        viewModel.fetchMovies()
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
}

// MARK: - UITableViewDataSource
extension MovieListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.movieData[section].type.rawValue.capitalized
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.movieData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getMovieCount(forSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movie = getMovie(atIndexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BasicMovieTableViewCell
        cell.configure(withMovie: movie)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

// MARK: - Data helpers
extension MovieListViewController {
    
    private func getMovieCount(forSection section: Int) -> Int {
        return viewModel.movieData[section].movies.content.count
    }
    
    private func getMovie(atIndexPath indexPath: IndexPath) -> Movie {
        return viewModel.movieData[indexPath.section].movies.content[indexPath.row]
    }
}

// MARK: - UITableViewDelegate
extension MovieListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - MovieListDelegate
extension MovieListViewController: MovieListDelegate {
    
    func moviesReceived() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
