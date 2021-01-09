//
//  MoviesServices.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import Alamofire

final class MoviesService {

    func getMoviesBy(genreId: Int, completionHandler: @escaping (MovieResponse?, Error?) -> Void) {
        Service.request(apiRouter: APIRouter.getMoviesBy(genreId: genreId),
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

    func getSimilarBy(movieId: Int, completionHandler: @escaping (MovieResponse?, Error?) -> Void) {
        Service.request(apiRouter: APIRouter.getSimilarBy(movieId: movieId),
                        completionHandler: completionHandler)
    }

    func getImageBy(movieId: Int, completionHandler: @escaping (ImageMovie?, Error?) -> Void) {
        Service.request(apiRouter: APIRouter.getImages(movieId: movieId),
                        completionHandler: completionHandler)
    }

    func getVideosBy(movieId: Int, completionHandler: @escaping (VideoResponse?, Error?) -> Void) {
        Service.request(apiRouter: APIRouter.getVideosBy(movieId: movieId),
                        completionHandler: completionHandler)
    }

    func getTopRated(completionHandler: @escaping (MovieResponse?, Error?) -> Void) {
        Service.request(apiRouter: APIRouter.getTopRated,
                        completionHandler: completionHandler)
    }

    func getUpcoming(completionHandler: @escaping (MovieResponse?, Error?) -> Void) {
        Service.request(apiRouter: APIRouter.getUpcoming,
                        completionHandler: completionHandler)
    }

    func getNowPlaying(completionHandler: @escaping (MovieResponse?, Error?) -> Void) {
        Service.request(apiRouter: APIRouter.getNowPlaying,
                        completionHandler: completionHandler)
    }

    func getLatest(completionHandler: @escaping (Movie?, Error?) -> Void) {
        Service.request(apiRouter: APIRouter.getLatest,
                        completionHandler: completionHandler)
    }
}
