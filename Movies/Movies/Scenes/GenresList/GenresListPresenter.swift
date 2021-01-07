//
//  GenresListPresenter.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import UIKit

protocol GenresListPresentationLogic {
    func presentGenresListResponse(_ response: GenresResponse)
    func presentError(_ response: ErrorModel)
    func presentMessage(_ response: MessageModel)
}

final class GenresListPresenter {
    weak var viewController: GenresListDisplayLogic?
}

// MARK: - GenresListPresentationLogic

extension GenresListPresenter: GenresListPresentationLogic {

    func presentError(_ response: ErrorModel) {
        viewController?.displayError(model: response)
    }

    func presentMessage(_ response: MessageModel) {
        viewController?.displayMessage(model: response)
    }

    func presentGenresListResponse(_ response: GenresResponse) {
        guard let genres = response.genres, !genres.isEmpty else {
            let message = MessageModel(title: "No Genres Founds",
                                        description: "",
                                        action: .reloadData)
            viewController?.displayMessage(model: message)
            return
        }
        let viewModel: [GenreListViewModel] = genres.map({ (model) -> GenreListViewModel in
            GenreListViewModel(model: model)
        })
        viewController?.displayGenresList(viewModel)
    }
}
