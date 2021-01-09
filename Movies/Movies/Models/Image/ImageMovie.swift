//
//  ImageMovie.swift
//  Movies
//
//  Created by DESARROLLO on 8/01/21.
//

struct ImageMovie {
    var id: String?
    var backdrops: [Backdrops]?
    var posters: [Posters]?

    struct Backdrops {
        var aspectRatio: Double?
        var filePath: String?
        var height: Int?
        var voteAverage: Int?
        var voteCount: Int?
        var width: Int?
    }

    struct Posters {
        var aspectRatio: Double?
        var filePath: String?
        var height: Int?
        var voteAverage: Int?
        var voteCount: Int?
        var width: Int?
    }
}

extension ImageMovie: Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case backdrops
        case posters
    }
}

extension ImageMovie.Backdrops: Codable {

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}

extension ImageMovie.Posters: Codable {

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }
}
