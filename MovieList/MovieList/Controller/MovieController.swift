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
    private let apiKey: String = "9de12758de4f4da163fb136f63b0bf58"
    private let language: String = "en-US"
    private var popularMovies: [Movie] = []

    private func setURL(_ pageNo: Int = 1) -> String {
        return "https://api.themoviedb.org/3/movie/popular?api_key=\(self.apiKey)&language=\(language)&page=\(pageNo)"
    }

    func getMorePopularMovies(_ pageNo: Int) {
        if let url = URL(string: setURL(pageNo)) {
            print(url)
            Network.shared.getMovies(url, completion: { (result) in
                switch result {
                case .success(let popularMovieResults):
                    
                        self.popularMovies.append(contentsOf: popularMovieResults.results ?? [] )
                        print("appended")
                    
        
                    
                case .failure(let error):
                    print(error)
                }
            })

        } else {

        }

    }

    func getPopularMovies() -> [Movie] {
         return self.popularMovies
    }

}
