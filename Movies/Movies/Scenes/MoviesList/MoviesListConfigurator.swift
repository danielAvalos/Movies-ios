//
//  MoviesListConfigurator.swift
//  Movies
//
//  Created by DESARROLLO on 7/01/21.
//

struct MoviesListConfigurator {

    static func configure(_ viewController: MoviesListViewController) {
        let service = MoviesService()
        let interactor = MoviesListInteractor(service: service)
        let presenter = MoviesListPresenter()
        let router = MoviesListRouter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        viewController.router = router
        router.viewController = viewController
        presenter.viewController = viewController
    }
}
