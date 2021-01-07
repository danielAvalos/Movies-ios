//
//  MoviesResponse.swift
//  Movies
//
//  Created by DESARROLLO on 7/01/21.
//

import Foundation

struct MoviesResponse {
    let movies: [MovieModel]?
}

extension MoviesResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case movies
    }
}
