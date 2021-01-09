//
//  MovieDetailInteractor.swift
//  Movies
//
//  Created by DESARROLLO on 7/01/21.
//

import Foundation

protocol MovieDetailBusinessLogic {
    func prepare()
}

protocol MovieDetailDataStore {
    var id: Int? { get set }
    var movie: MovieDetail? { get }
}

final class MovieDetailInteractor: MovieDetailDataStore {

    var presenter: MovieDetailPresentationLogic?

    private let service: MoviesService

    // MARK: - MovieDetailDataStore
    var id: Int?
    var movie: MovieDetail?

    init(service: MoviesService) {
        self.service = service
    }
}

// MARK: - MovieDetailBusinessLogic

extension MovieDetailInteractor: MovieDetailBusinessLogic {

    func prepare() {
        guard let id = id else {
            return
        }
        guard ReachabilityManager.shared.isConnected == true else {
            presenter?.presentError(Error(code: .notConnection))
            return
        }
        service.getDetail(id: id) { [weak self] (response, error) in
            guard let strongSelf = self,
                  let model = response else {
                return
            }
            strongSelf.movie = response
            guard let error = error else {
                strongSelf.presenter?.presentResponse(strongSelf.createResponse(model: model))
                return
            }
            strongSelf.presenter?.presentError(error)
        }
    }
}

// MARK: - Private functions

private extension MovieDetailInteractor {

    func createResponse(model: MovieDetail) -> MovieDetail {
        model
    }
}
