//
//  GenresListPresenter.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import UIKit

protocol GenresListPresentationLogic {
    func presentGenresListResponse(_ response: GenreListResponse)
}

final class GenresListPresenter {
    weak var viewController: GenresListDisplayLogic?
}

// MARK: - GenresListPresentationLogic

extension GenresListPresenter: GenresListPresentationLogic {

    func presentGenresListResponse(_ response: GenreListResponse) {
    }
}
