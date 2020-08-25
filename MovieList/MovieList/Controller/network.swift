//
//  network.swift
//  MovieList
//
//  Created by ismet sarı on 11.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import Foundation

class Network {
    
    static let shared = Network()
    private let apiKey: String = "9de12758de4f4da163fb136f63b0bf58"
    private let language: String = "en-US"
    static var page: Int = 1
    
    private func setURL(_ pageNo: Int = 1) -> String {
        return "https://api.themoviedb.org/3/movie/popular?api_key=\(self.apiKey)&language=\(language)&page=\(pageNo)"
    }
    
    func setURLForMovieDetail(_ movieID: Int) -> String {
        return "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(self.apiKey)&language=\(self.language)"
    }
    
    func getMovieDetail(_ movieID: Int, completion: @escaping ((Result<MovieDetails, Error>) -> Void)) {

        if let urlForMovieDetail = URL(string: self.setURLForMovieDetail(movieID)) {
            var request = URLRequest(url: urlForMovieDetail)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")

            let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode(MovieDetails.self, from: data)
                        completion(.success(result))
                    } catch let error {
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


    }
    
    func getMovieDetail2(_ movieID: Int, completion: @escaping ((Result<MovieDetails, FailureError>) -> Void)) {
        
        if let urlForMovieDetail = URL(string: self.setURLForMovieDetail(movieID)) {
            var request = URLRequest(url: urlForMovieDetail)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    
                    if let httpResponse = response as? HTTPURLResponse {
                        switch httpResponse.statusCode {
                        case 200:
                            do {
                                let result = try JSONDecoder().decode(MovieDetails.self, from: data)
                                completion(.success(result))
                            } catch let error {
                                print("error")
                                completion(.failure(FailureError(statusMassage: "Error decoding from data", statusCode: 200)))
                            }
                        case 401,404:
                            do {
                                let failureResult = try JSONDecoder().decode(FailureError.self, from: data)
                                completion(.failure(failureResult))
                            } catch let error {
                                print("error")
                                completion(.failure(FailureError(statusMassage: "Error at response of failure", statusCode: 200)))
                            }
                        default:
                            completion(.failure(FailureError(statusMassage: "Error at response of failure", statusCode: 200)))
                        }
                    }
                }
                else {
                    if let theError = error {
                        completion(.failure(FailureError(statusMassage: theError.localizedDescription, statusCode: 201)))
                    }
                }
            }
            dataTask.resume()
        }
        
        
    }
    
    func getMovies(_ pageNo: Int, completion: @escaping ((Result<MovieResults, Error>) -> Void)) {
        
        if let urlForMovie = URL(string: self.setURL(pageNo)){
            var request = URLRequest(url: urlForMovie)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let dataTask = URLSession.shared.dataTask(with: request) { (data, _, error) in
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode(MovieResults.self, from: data)
                        completion(.success(result))
                    } catch let error {
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
        
        
        
    }
    
}
