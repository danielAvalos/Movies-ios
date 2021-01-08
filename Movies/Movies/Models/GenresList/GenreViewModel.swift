//
//  GenreListViewModel.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

final class GenreViewModel: GenreRepresentable {

    var model: Genre

    init(model: Genre) {
        self.model = model
    }
}

extension GenreViewModel: Equatable {
    static func == (lhs: GenreViewModel, rhs: GenreViewModel) -> Bool {
        return lhs.model.id == lhs.model.id
    }
}

protocol GenreRepresentable {
    var model: Genre { get set }
}

protocol GenreConfigurable {
    func configure(with viewModel: GenreRepresentable)
}
