//
//  PopularMovie.swift
//  MovieList
//
//  Created by ismet sarı on 11.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import Foundation

struct PopularMovies:Codable {
    
    let overview: String?
    let poster_path: String?
    let vote_average: Double?
    let release_date: String?
    let popularity: Double?
    
    
    let genre_ids: [Int]?
    let id: Int?
    let title: String?
    
    let lan: String?
    
    enum CodingKeys: String, CodingKey {
        case overview, genre_ids, id, title, release_date, vote_average, poster_path, popularity
        case lan = "original_language"
    }
    
    
}

extension PopularMovies: Equatable {
    
    static func ==(lhs:PopularMovies, rhs:PopularMovies) -> Bool{
        return lhs.id == rhs.id
    }
}
