//
//  MoviesResponse.swift
//  Movies
//
//  Created by DESARROLLO on 7/01/21.
//

import Foundation

struct MovieResponse {
    var id: Int?
    var page: Int?
    var movies: [Movie]?
    var isSearching: Bool?
}

extension MovieResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case page
        case movies = "results"
    }
}
