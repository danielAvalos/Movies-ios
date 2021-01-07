//
//  MoviesServices.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import Alamofire

final class MoviesService {

    func getMoviesByGenre(id: Int, completionHandler: @escaping (MoviesResponse?, ErrorModel?) -> Void) {
        Service.request(apiRouter: APIRouter.getMoviesByGenre(id: id),
                        completionHandler: completionHandler)
    }
}
