//
//  KnownFor.swift
//  MovieList
//
//  Created by ismet sarı on 29.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import Foundation

struct KnownFor {
    let posterPath: String?
    let id: Int?
    let title: String?
    let rate: Double?
    enum CodingKeys: String, CodingKey {
        case id
        case rate = "vote_average", title = "original_title", posterPath = "poster_path"
    }
}
