//
//  FailureError.swift
//  MovieList
//
//  Created by ismet sarı on 25.08.2020.
//  Copyright © 2020 ismet sarı. All rights reserved.
//

import Foundation

struct FailureError: Codable, Error, LocalizedError {
    let statusMassage: String?
    let statusCode: Int?
    
    enum CodingKeys: String, CodingKey {
        case statusMassage = "status_message", statusCode = "status_code"
    }
    
}
