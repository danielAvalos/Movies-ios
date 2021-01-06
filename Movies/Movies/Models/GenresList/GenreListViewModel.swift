//
//  GenreListViewModel.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

final class GenreListViewModel: GenreListRepresentable {

    var model: GenreModel

    init(model: GenreModel) {
        self.model = model
    }
}

extension GenreListViewModel: Equatable {
    static func == (lhs: GenreListViewModel, rhs: GenreListViewModel) -> Bool {
        return lhs.model.id == lhs.model.id
    }
}

protocol GenreListRepresentable {
    var model: GenreModel { get set }
}

protocol GenreListConfigurable {
    func configure(with viewModel: GenreListRepresentable)
}
