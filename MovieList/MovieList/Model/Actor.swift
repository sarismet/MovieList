//
//  Actor.swift
//  MovieList
//
//  Created by ismet sarı on 29.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import Foundation

struct Actor {
    let name: String?
    let id: Int?
    let posterPath: String?
    let popularity: Double?
    let department: String?
    enum CodingKeys: String, CodingKey {
        case id, name, popularity
        case posterPath = "profile_path", department = "known_for_department"

    }
}