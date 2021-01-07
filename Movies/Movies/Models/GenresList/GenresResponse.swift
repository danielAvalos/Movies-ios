//
//  GenreListResponse.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

struct GenresResponse {
    var genres: [GenreModel]?
    var isSearching: Bool?
}

extension GenresResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case genres
    }
}
