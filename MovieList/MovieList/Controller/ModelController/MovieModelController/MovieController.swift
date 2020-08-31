//
//  MovieController.swift
//  MovieList
//
//  Created by ismet sarı on 20.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import Foundation

class MovieController {

    static let shared = MovieController()

    private var popularMovies: [Int: Movie] = [:]

    func getTheMovie(_ movieID: Int) -> Movie? {
        return self.popularMovies[movieID]
    }

    func addPopularMovies(_ newMovieList: [Movie]) {

        for movie in newMovieList {
            if let theID = movie.id {
                self.popularMovies[theID] = movie
            }

        }
    }

    func getLoad() {

    }

    func getPopularMovies() -> [Movie] {
        return Array(self.popularMovies.values)
    }

}
