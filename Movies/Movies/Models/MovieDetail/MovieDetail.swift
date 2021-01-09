//
//  MovieDetail.swift
//  Movies
//
//  Created by DESARROLLO on 7/01/21.
//

import Foundation

struct MovieDetail: MovieProtocol {

    var adult: Bool?
    var backdropPath: String?
    var genreIds: [Int]?
    var id: Int?
    var originalLanguage: String?
    var originalTitle: String?
    var overview: String?
    var popularity: Double?
    var posterPath: String?
    var title: String?
    var video: Bool?
    var voteAverage: Double?
    var voteCount: Int?
    var budget: Int64?
    var genres: [Genre]?
    var homepage: String?
    var imdbId: String?
    var revenue: Int64?
    var runtime: Int?
    var status: String?
    var tagline: String?
    var belongsToCollection: BelongsToCollection?
    var productionCompanies: ProductionCompanies?
    var productionCountries: ProductionCountries?
    var spokenLanguages: [SpokenLanguages]?

    struct ProductionCompanies {
        var id: Int?
        var logoPath: String?
        var name: String?
        var originCountry: String?
    }

    struct BelongsToCollection {
        var id: Int?
        var name: String?
        var posterPath: String?
        var backdropPath: String?
    }

    struct ProductionCountries {
        var iso31661: String?
        var name: String?
    }

    struct SpokenLanguages {
        var englishName: String?
        var iso6391: String?
        var name: String?
    }
}

extension MovieDetail: Codable {

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
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "voteCount"
    }
}
