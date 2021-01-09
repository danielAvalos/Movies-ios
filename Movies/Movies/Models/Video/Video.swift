//
//  Video.swift
//  Movies
//
//  Created by DESARROLLO on 8/01/21.
//

import Foundation

enum SiteType: String {
    case youtube = "YouTube"
    case vimeo = "Vimeo"
}

struct Video {
    var id: String?
    var iso6391: String?
    var iso31661: String?
    var key: String?
    var name: String?
    var site: String?
    var size: Int?
    var type: String?
}

extension Video: Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case iso6391 = "iso_639_1"
        case iso31661 = "iso_3166_1"
        case key
        case name
        case site
        case size
        case type
    }
}
