//
//  FavoriMoviesController.swift
//  MovieList
//
//  Created by ismet sarı on 20.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import Foundation

class FavoriMoviesController {
    
    static let shared = FavoriMoviesController()
    
    init(){
        if let data =  UserDefaults.standard.data(forKey: "myFavoritesX"){
            do {
                let decoder = JSONDecoder()
                self.favoriMovies = try decoder.decode(FavoritesModel.self, from: data)
            }
            catch {
                print("There is an error while decoding")
            }
        }
    }
    
    private var favoriMovies: FavoritesModel = FavoritesModel() {
        
        didSet {
            do {
                let encoder = JSONEncoder()
                let data = try encoder.encode(favoriMovies)
                UserDefaults.standard.set(data, forKey: "myFavoritesX")
            }
            catch {
                print("There is an error while encoding")
            }
        }
        
    }
    
    func getSavedFavoriMovies() -> [Movie]{
        self.favoriMovies.favorites
    }
    
    func getTheFavoriMovie(_ movieID: Int ) -> Movie {
      return  self.favoriMovies.favorites.first( where : { $0.id == movieID })! //HELP!!!
    }
    
    func bringTheAction(_ movie: Movie?) -> Bool {
        if let theMovie = movie, let movieID = movie?.id {
            if isFavorite(theMovie){
                if let index = self.favoriMovies.favorites.firstIndex(where: { $0.id == movieID}) {
                    print("removing!!!")
                    self.favoriMovies.favorites.remove(at: index)
                    return false
                    //self.favoriMovies.isFavoried[index] = false
                }
            }
            else {
               print("adding")
                self.favoriMovies.favorites.append(theMovie)
                    //self.favoriMovies.isFavoried[index] = true
                return true
                
            }
            
        }
        return false
    }
    
    func isFavorite(_ movie: Movie) -> Bool {
        return favoriMovies.favorites.contains(movie) ? true : false
    }
    
}
