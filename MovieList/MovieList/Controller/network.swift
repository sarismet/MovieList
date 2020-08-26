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
    
    func getPopularMovies(_ pageNo: Int, completion: @escaping ((Result<MovieResults, ApıError>) -> Void)) {
        
        let url: String = "https://api.themoviedb.org/3/movie/popular?api_key=\(self.apiKey)&language=\(language)&page=\(pageNo)"
        if let urlForMovie = URL(string: url){
            var request = URLRequest(url: urlForMovie)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            self.getFromApı(request, completion: completion)
            
        }
    }
    
    func getDetails(_ movieID: Int, completion: @escaping ((Result<MovieDetails, ApıError>) -> Void)) {
        
        let url: String = "https://api.themoviedb.org/3/movie/\(movieID)?api_key=\(self.apiKey)&language=\(self.language)"
        if let urlForMovie = URL(string: url){
            var request = URLRequest(url: urlForMovie)
            request.httpMethod = "GET"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            self.getFromApı(request, completion: completion)
            
        }
    }
    
    
    func getFromApı<T:Decodable>(_ request: URLRequest , completion: @escaping ((Result<T, ApıError>) -> Void)) {
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200:
                        do {
                            let result = try JSONDecoder().decode(T.self, from: data)
                            completion(.success(result))
                        } catch let error {
                            print("error")
                            completion(.failure(ApıError.customError(message: error.localizedDescription)))
                        }
                    case 401:
                        completion(.failure(ApıError.invalidApıKey))
                    case 404:
                        
                        completion(.failure(ApıError.resourceNotFound))
                        
                    default:
                        completion(.failure(ApıError.customError(message: "Error exist")))
                    }
                }
            }
        }
        dataTask.resume()
    }
}

enum ApıError: Error {
    case invalidApıKey
    case resourceNotFound
    case customError(message: String)
    var errorMessage :String {
        switch self {
        case .invalidApıKey:
            return "invalid api key"
        case .resourceNotFound:
            return "resource is not found"
        case .customError(let message):
            return message
        }
    }
}
