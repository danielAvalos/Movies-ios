//
//  MoviesListInteractor.swift
//  Movies
//
//  Created by DESARROLLO on 7/01/21.
//

import Foundation

protocol MoviesListBusinessLogic {
    func prepareList()
    func filterContent(forQuery query: String?)
}

protocol MoviesListDataStore {
    var genreId: Int? { get set }
    var movieType: MoviesType { get set}
    var isSearching: Bool { get set }
    var moviesList: [Movie] { get }
}

final class MoviesListInteractor: MoviesListDataStore {

    var presenter: MoviesListPresentationLogic?

    private let service: MoviesService

    // MARK: - MoviesListDataStore
    var movieType: MoviesType = .popular
    var isSearching: Bool = false
    var moviesList: [Movie] = []
    var genreId: Int?

    init(service: MoviesService) {
        self.service = service
    }
}

// MARK: - MoviesListBusinessLogic

extension MoviesListInteractor: MoviesListBusinessLogic {

    func filterContent(forQuery query: String?) {
        guard let query = query, !query.isEmpty else {
            presenter?.presentListResponse(createResponse(model: moviesList))
            return
        }
        isSearching = true
        let searchResult = moviesList.filter {
            return $0.title?.lowercased().contains(query.lowercased()) == true ||
                $0.originalTitle?.lowercased().contains(query.lowercased()) == true
        }
        presenter?.presentListResponse(createResponse(model: searchResult))
    }

    func prepareList() {
        isSearching = false
        guard ReachabilityManager.shared.isConnected else {
            let response = Error(code: .notConnection)
            presenter?.presentError(response)
            return
        }
        switch movieType {
        case .latest:
            callLatestMovies()
        case .topRated:
            callTopRatedMovies()
        case .upcoming:
            callUpcomingMovies()
        case .popular:
            callPopularsMovies()
        case .nowPlaying:
            callNowPlayingsMovies()
        }
    }

    func responseCall(_ model: MovieResponse?, _ error: Error?) {
        guard let model = model else {
            return
        }
        guard let error = error else {
            moviesList = model.movies ?? []
            presenter?.presentListResponse(createResponse(model: moviesList))
            return
        }
        presenter?.presentError(error)
    }
}

// MARK: - Private functions

private extension MoviesListInteractor {

    func createResponse(model: [Movie]) -> MovieResponse {
        return MovieResponse(movies: model, isSearching: isSearching)
    }

    func callLatestMovies() {
        service.getLatest { [weak self] (model, error) in
            guard let strongSelf = self,
                  let model = model else {
                return
            }
            strongSelf.responseCall(strongSelf.createResponse(model: [model]), error)
        }
    }

    func callPopularsMovies() {
        service.getPopular { [weak self] (model, error) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.responseCall(model, error)
        }
    }

    func callTopRatedMovies() {
        service.getTopRated { [weak self] (model, error) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.responseCall(model, error)
        }
    }

    func callNowPlayingsMovies() {
        service.getNowPlaying { [weak self] (model, error) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.responseCall(model, error)
        }
    }

    func callUpcomingMovies() {
        service.getUpcoming { [weak self] (model, error) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.responseCall(model, error)
        }
    }
}
