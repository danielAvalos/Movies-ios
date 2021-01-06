//
//  GenresListConfigurator.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import Foundation

struct GenresListConfigurator {

    static func configure(_ viewController: GenresListTableViewController) {
        let service = MoviesService()
        let interactor = GenresListInteractor(service: service)
        let presenter = GenresListPresenter()
        let router = GenresListRouter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        viewController.router = router
        router.viewController = viewController
        presenter.viewController = viewController
    }
}
