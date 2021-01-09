//
//  MovieDetailPresenter.swift
//  Movies
//
//  Created by DESARROLLO on 7/01/21.
//

import UIKit

protocol MovieDetailPresentationLogic {
    func presentResponse(_ response: MovieDetail)
    func presentError(_ response: Error)
    func presentMessage(_ response: Message)
}

final class MovieDetailPresenter {
    weak var viewController: MovieDetailDisplayLogic?
}

// MARK: - MovieDetailPresentationLogic

extension MovieDetailPresenter: MovieDetailPresentationLogic {

    func presentError(_ response: Error) {
        viewController?.displayError(model: response)
    }

    func presentMessage(_ response: Message) {
        viewController?.displayMessage(model: response)
    }

    func presentResponse(_ response: MovieDetail) {
        let viewModel = MovieDetailViewModel(model: response)
        viewController?.displayData(viewModel)
    }
}
