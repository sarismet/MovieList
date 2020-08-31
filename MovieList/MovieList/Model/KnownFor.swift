//
//  KnownFor.swift
//  MovieList
//
//  Created by ismet sarı on 29.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import Foundation

struct KnownFor: Codable {
    let id: Int
    let overview: String?
    let posterPath: String?
    enum CodingKeys: String, CodingKey {
        case id, overview
        case posterPath = "poster_path"
    }
}
