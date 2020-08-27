//
//  Movie.swift
//  MovieList
//
//  Created by ismet sarı on 20.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import Foundation

struct Movie: Codable {

    let overview: String?
    let posterPath: String?
    let releaseDate: String?
    let rate: Double?
    let id: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case overview, id, title, releaseDate
        case rate = "vote_average", posterPath = "poster_path"
    }

}

extension Movie: Equatable {

    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}
