//
//  GenresListRouter.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import Foundation

protocol GenresListRoutingLogic {
    func navigateToMoviesByGenre(id: Int)
}

// MARK: - GenresListRoutingLogic

final class GenresListRouter: NSObject, GenresListRoutingLogic {

    weak var viewController: GenresListTableViewController?

    func  navigateToMoviesByGenre(id: Int) {
    }
}
