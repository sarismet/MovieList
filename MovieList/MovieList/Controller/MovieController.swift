//
//  MovieController.swift
//  MovieList
//
//  Created by ismet sarı on 20.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import Foundation

class MovieController {

    static let sharedMovieController = MovieController()

    private var popularMovies: [Movie] = []


    func getMorePopularMovies(_ pageNo: Int) {
        
            Network.shared.getMovies(pageNo, completion: { (result) in
                switch result {
                case .success(let popularMovieResults):
                    
                        self.popularMovies.append(contentsOf: popularMovieResults.results ?? [] )    
                case .failure(let error):
                    print(error)
                }
            })

        }

    

    func getPopularMovies() -> [Movie] {
         return self.popularMovies
    }

}
