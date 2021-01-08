//
//  MovieDetailConfigurator.swift
//  Movies
//
//  Created by DESARROLLO on 7/01/21.
//

struct MovieDetailConfigurator {

    static func configure(_ viewController: MovieDetailViewController) {
        let service = MoviesService()
        let interactor = MovieDetailInteractor(service: service)
        let presenter = MovieDetailPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
    }
}
