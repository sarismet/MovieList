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
    let poster_path: String?
    let release_date: String?
    let popularity: Double?

    let rate: Double?

    let genre_ids: [Int]?
    let id: Int?
    let title: String?

    let lan: String?

    enum CodingKeys: String, CodingKey {
        case overview, genre_ids, id, title, release_date, poster_path, popularity
        case lan = "original_language", rate = "vote_average"
    }

}

extension Movie: Equatable {

    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}
