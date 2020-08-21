//
//  MovieDetailController.swift
//  MovieList
//
//  Created by ismet sarı on 20.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import Foundation

class MovieDetailController {

    static let sharedMovieDetailController = MovieDetailController()

    
    init(){
        self.movieDetails = [:]
    }
    
    private let apiKey: String = "9de12758de4f4da163fb136f63b0bf58"
    private let language: String = "en-US"
    
    private var movieDetails: [Int:MovieDetails]

    
    
    func getMovieDetail(_ movieID: Int) -> MovieDetails {
        if let movieDetail = self.movieDetails[movieID] {
            return movieDetail
        }
        return self.getMovieDetailInfo(movieID)
    }

    func setURLForMovieDetail(_ movieID: Int) -> String {
        return "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(self.apiKey)&language=\(self.language)"
    }

    func getMovieDetailInfo(_ movieID: Int) -> MovieDetails {
        
        if let url = URL(string: setURLForMovieDetail(movieID)) {
            
            Network.shared.getMovieDetail(url, completion: { (result) in
                           switch result {
                           case .success(let allTheDetails):
                             DispatchQueue.main.async {
                                self.movieDetails[movieID] = allTheDetails
                             }
                            
                           case .failure(let error):
                               print(error)
                           }
            })
            
        }

        return self.movieDetails[movieID]! //need HELP!!!
    }

}
