//
//  MovieModel.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import Foundation

protocol MovieProtocol {
    var adult: Bool? { get set }
    var backdropPath: String? { get set }
    var genreIds: [Int]? { get set }
    var id: Int? { get set }
    var originalLanguage: String? { get set }
    var originalTitle: String? { get set }
    var overview: String? { get set }
    var popularity: Double? { get set }
    var posterPath: String? { get set }
    var releaseDate: Date? { get set }
    var title: String? { get set }
    var video: Bool? { get set }
    var voteAverage: Double? { get set }
    var voteCount: Int? { get set }
}

struct Movie: MovieProtocol {
    var adult: Bool?
    var backdropPath: String?
    var genreIds: [Int]?
    var id: Int?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var releaseDate: Date?
    var title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
}

extension Movie: Codable {

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIds = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "voteCount"
    }
}
