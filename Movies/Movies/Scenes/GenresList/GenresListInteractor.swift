//
//  GenresListInteractor.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

protocol GenresListBusinessLogic {
    func prepareGenresList()
    func filterContent(forQuery query: String?)
}

protocol GenresListDataStore {
    var isSearching: Bool { get set }
    var genresList: [GenreModel] { get }
}

final class GenresListInteractor: GenresListDataStore {

    var presenter: GenresListPresentationLogic?

    private let service: GenresService

    // MARK: - GenresListDataStore

    var isSearching: Bool = false
    var genresList: [GenreModel] = []

    init(service: GenresService) {
        self.service = service
    }
}

// MARK: - GenresListBusinessLogic

extension GenresListInteractor: GenresListBusinessLogic {

    func filterContent(forQuery query: String?) {
        guard let query = query, !query.isEmpty else {
            return
        }
        isSearching = true
    }

    func prepareGenresList() {
        isSearching = false
        if ReachabilityManager.shared.isConnected {
            service.getGenresList { [weak self] (model, error) in
                guard let strongSelf = self,
                      let model = model else {
                    return
                }
                guard let error = error else {
                    strongSelf.genresList = model.genres ?? []
                    strongSelf.presenter?.presentGenresListResponse(strongSelf.createGenreListResponse(model: strongSelf.genresList))
                    return
                }
                strongSelf.presenter?.presentError(error)
            }
        } else {
        }
    }
}

// MARK: - Private functions

private extension GenresListInteractor {

    func createGenreListResponse(model: [GenreModel]) -> GenresResponse {
        return GenresResponse(genres: model, isSearching: isSearching)
    }
}
