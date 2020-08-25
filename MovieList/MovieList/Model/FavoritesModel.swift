//
//  FavoritesModel.swift
//  MovieList
//
//  Created by ismet sarı on 23.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import Foundation

struct FavoritesModel: Codable {
    
    var favorites: [Movie] = []
    var isFavoried: [Int:Bool] = [-1:false]
    
    

}
