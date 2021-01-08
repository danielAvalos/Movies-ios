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
    var movie: MovieDetail? { get }
}

final class MovieDetailInteractor: MovieDetailDataStore {

    var presenter: MovieDetailPresentationLogic?

    private let service: MoviesService

    // MARK: - MovieDetailDataStore

    var movie: MovieDetail?

    init(service: MoviesService) {
        self.service = service
    }
}

// MARK: - GenresListBusinessLogic

extension MovieDetailInteractor: MovieDetailBusinessLogic {

    func prepare() {
        if ReachabilityManager.shared.isConnected {
            service.getPopular { [weak self] (model, error) in
                guard let strongSelf = self,
                      let model = model else {
                    return
                }
                guard let error = error else {
                    return
                }
                strongSelf.presenter?.presentError(error)
            }
        } else {
        }
    }
}

// MARK: - Private functions

private extension MovieDetailInteractor {

    func createResponse(model: MovieDetail) -> MovieDetailResponse {
        return MovieDetailResponse()
    }
}
