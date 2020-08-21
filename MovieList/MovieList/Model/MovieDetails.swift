//
//  MovieDetails.swift
//  MovieList
//
//  Created by ismet sarı on 21.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import Foundation

struct MovieDetails: Codable {
    
    let backgroundImage: String?
    let genres: [Genre]?
    let netflixURL: URL?
    let imdbID: String?
    let language: String?
    let overview: String?
    let id: Int?
    let posterImage: String?
    let productionCompanies: [Producer]?
    let releaseDate: String?
    let runtime: Int? //"Expected to decode String but found a number instead."
    let spokenLanguages: [SpokenLanguages]?
    let tagline: String?
    let title: String?
    let rate: Double?
    
    
    
    enum CodingKeys: String, CodingKey {
        case overview, genres, runtime, tagline, title, id
        case language = "original_language", backgroundImage = "backdrop_path", netflixURL = "homepage", imdbID = "imdb_id"
        case posterImage = "poster_path", productionCompanies = "production_companies", releaseDate = "release_date"
        case rate = "vote_average", spokenLanguages = "spoken_languages"
    }
    
}

