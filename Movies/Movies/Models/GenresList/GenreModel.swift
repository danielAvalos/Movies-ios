//
//  GenreModel.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import Foundation

struct GenreModel {

    let id: Int?
    let name: String?
}

extension GenreModel: Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
}
