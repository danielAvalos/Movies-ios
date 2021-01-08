//
//  MoviesListPresenter.swift
//  Movies
//
//  Created by DESARROLLO on 7/01/21.
//

import UIKit

protocol MoviesListPresentationLogic {
    func presentListResponse(_ response: MovieResponse)
    func presentError(_ response: Error)
    func presentMessage(_ response: Message)
}

final class MoviesListPresenter {
    weak var viewController: MoviesDisplayLogic?
}

// MARK: - MoviesListPresentationLogic

extension MoviesListPresenter: MoviesListPresentationLogic {

    func presentError(_ response: Error) {
        viewController?.displayError(model: response)
    }

    func presentMessage(_ response: Message) {
        viewController?.displayMessage(model: response)
    }

    func presentListResponse(_ response: MovieResponse) {
        guard let movies = response.movies, !movies.isEmpty else {
            let message = Message(title: "No Movies Founds",
                                        description: "",
                                        action: .reloadData)
            viewController?.displayMessage(model: message)
            return
        }
        let viewModel: [MovieViewModel] = movies.map({ (model) -> MovieViewModel in
            MovieViewModel(model: model)
        })
        viewController?.displayList(viewModel)
    }
}
