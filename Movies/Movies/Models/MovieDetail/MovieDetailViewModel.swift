//
//  MovieDetailViewModel.swift
//  Movies
//
//  Created by DESARROLLO on 7/01/21.
//

import Foundation

final class MovieDetailViewModel: MovieDetailRepresentable {

    var model: MovieDetail

    init(model: MovieDetail) {
        self.model = model
    }
}

extension MovieDetailViewModel: Equatable {
    static func == (lhs: MovieDetailViewModel, rhs: MovieDetailViewModel) -> Bool {
        return lhs.model.id == lhs.model.id
    }
}

protocol MovieDetailRepresentable {
    var model: MovieDetail { get set }
}

protocol MovieDetailConfigurable {
    func configure(with viewModel: MovieDetailRepresentable)
}
