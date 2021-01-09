//
//  MovieViewModel.swift
//  Movies
//
//  Created by DESARROLLO on 7/01/21.
//

final class MovieViewModel: MovieRepresentable {

    var model: Movie

    init(model: Movie) {
        self.model = model
    }
}

extension MovieViewModel: Equatable {
    static func == (lhs: MovieViewModel, rhs: MovieViewModel) -> Bool {
        return lhs.model.id == lhs.model.id
    }
}

protocol MovieRepresentable {
    var model: Movie { get set }
}

protocol MovieConfigurable {
    func configure(with viewModel: MovieRepresentable)
}
