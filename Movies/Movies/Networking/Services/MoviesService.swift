//
//  MoviesServices.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import Alamofire

final class MoviesService {

    func getMoviesByGenre(id: Int, completionHandler: @escaping (MovieResponse?, Error?) -> Void) {
        Service.request(apiRouter: APIRouter.getMoviesByGenre(id: id),
                        completionHandler: completionHandler)
    }

    func getPopular(completionHandler: @escaping (MovieResponse?, Error?) -> Void) {
        Service.request(apiRouter: APIRouter.getPopular,
                        completionHandler: completionHandler)
    }

    func getDetail(id: Int, completionHandler: @escaping (MovieDetail?, Error?) -> Void) {
        Service.request(apiRouter: APIRouter.getMovieDetail(id: id),
                        completionHandler: completionHandler)
    }
}
