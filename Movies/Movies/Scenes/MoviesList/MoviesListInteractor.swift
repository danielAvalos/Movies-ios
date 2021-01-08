//
//  MoviesListInteractor.swift
//  Movies
//
//  Created by DESARROLLO on 7/01/21.
//

protocol MoviesListBusinessLogic {
    func prepareList()
    func filterContent(forQuery query: String?)
}

protocol MoviesListDataStore {
    var genreId: Int? { get set }
    var isSearching: Bool { get set }
    var moviesList: [Movie] { get }
}

final class MoviesListInteractor: MoviesListDataStore {

    var presenter: MoviesListPresentationLogic?

    private let service: MoviesService

    // MARK: - GenresListDataStore

    var isSearching: Bool = false
    var moviesList: [Movie] = []
    var genreId: Int?

    init(service: MoviesService) {
        self.service = service
    }
}

// MARK: - GenresListBusinessLogic

extension MoviesListInteractor: MoviesListBusinessLogic {

    func filterContent(forQuery query: String?) {
        guard let query = query, !query.isEmpty else {
            presenter?.presentListResponse(createResponse(model: moviesList))
            return
        }
        isSearching = true
        let searchResult = moviesList.filter { _ in
            "$0.id?".lowercased().contains(query.lowercased()) == true
        }
        presenter?.presentListResponse(createResponse(model: searchResult))
    }

    func prepareList() {
        isSearching = false
        if ReachabilityManager.shared.isConnected {
            service.getPopular { [weak self] (model, error) in
                guard let strongSelf = self,
                      let model = model else {
                    return
                }
                guard let error = error else {
                    strongSelf.moviesList = model.movies ?? []
                    strongSelf.presenter?.presentListResponse(strongSelf.createResponse(model: strongSelf.moviesList))
                    return
                }
                strongSelf.presenter?.presentError(error)
            }
        } else {
        }
    }
}

// MARK: - Private functions

private extension MoviesListInteractor {

    func createResponse(model: [Movie]) -> MovieResponse {
        return MovieResponse(movies: model, isSearching: isSearching)
    }
}
