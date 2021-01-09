//
//  VideoResponse.swift
//  Movies
//
//  Created by DESARROLLO on 8/01/21.
//

import Foundation

struct VideoResponse {
    var id: Int?
    var results: [Video]?
}

extension VideoResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case results
    }
}
