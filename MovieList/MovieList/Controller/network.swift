//
//  network.swift
//  MovieList
//
//  Created by ismet sarı on 11.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import Foundation
import Alamofire

class Network {

    static let shared = Network()
    private let apiKey: String = "9de12758de4f4da163fb136f63b0bf58"
    private let language: String = "en-US"
    static var page: Int = 1
 
    
    
    func setURL(_ pageNo: Int = 1) -> String {
            return "https://api.themoviedb.org/3/movie/popular?api_key=\(self.apiKey)&language=\(language)&page=\(pageNo)"
    }
    
    func setURLForMovieDetail(_ movieID: Int) -> String {
        return "https://api.themoviedb.org/3/movie/\(movieID)?api_key=9de12758de4f4da163fb136f63b0bf58&language=en-US"
    }
    
    func getMovieDetail(_ movieID: Int, completion: @escaping ((Result<Details, Error>) -> Void)) {

            print("gelen id is \(movieID)")
        var request = URLRequest(url: URL(string: setURLForMovieDetail(movieID))!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Details.self, from: data)
                    completion(.success(result))
                } catch(let error) {
                    completion(.failure(error))
                }
            } else {
                if let error = error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()

    }


    func getMovies(completion: @escaping ((Result<PopularMovieResults, Error>) -> Void)) {

        var request = URLRequest(url: URL(string: setURL())!)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(PopularMovieResults.self, from: data)
                    completion(.success(result))
                } catch(let error) {
                    completion(.failure(error))
                }
            } else {
                if let error = error {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()

    }


    func getMoviesWithAlamofire(completion: @escaping ((Result<PopularMovieResults, AFError>) -> Void)) {
        AF.request(URL(string: setURL())!, method: .get).responseDecodable(of: PopularMovieResults.self) { (response) in
            completion(response.result)
        }
    }

}
