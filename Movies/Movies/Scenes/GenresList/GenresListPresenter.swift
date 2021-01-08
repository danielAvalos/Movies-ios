//
//  GenresListPresenter.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import UIKit

protocol GenresListPresentationLogic {
    func presentGenresListResponse(_ response: GenresResponse)
    func presentError(_ response: Error)
    func presentMessage(_ response: Message)
}

final class GenresListPresenter {
    weak var viewController: GenresListDisplayLogic?
}

// MARK: - GenresListPresentationLogic

extension GenresListPresenter: GenresListPresentationLogic {

    func presentError(_ response: Error) {
        viewController?.displayError(model: response)
    }

    func presentMessage(_ response: Message) {
        viewController?.displayMessage(model: response)
    }

    func presentGenresListResponse(_ response: GenresResponse) {
        guard let genres = response.genres, !genres.isEmpty else {
            let message = Message(title: "No Genres Founds",
                                        description: "",
                                        action: .reloadData)
            viewController?.displayMessage(model: message)
            return
        }
        let viewModel: [GenreViewModel] = genres.map({ (model) -> GenreViewModel in
            GenreViewModel(model: model)
        })
        viewController?.displayGenresList(viewModel)
    }
}
