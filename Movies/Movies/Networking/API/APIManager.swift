//
//  APIManager.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import Alamofire

enum APIRouter: URLRequestConvertible {

    case getGenresList
    case getMoviesBy(genreId: Int)
    case getPopular
    case getImages(movieId: Int)
    case getMovieDetail(id: Int)
    case getSimilarBy(movieId: Int)
    case getVideosBy(movieId: Int)
    case getTopRated
    case getUpcoming
    case getLatest

    var method: HTTPMethod {
        switch self {
        case .getGenresList,
             .getMoviesBy,
             .getImages,
             .getPopular,
             .getMovieDetail,
             .getSimilarBy,
             .getVideosBy,
             .getTopRated,
             .getUpcoming,
             .getLatest:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getGenresList:
            return "/genre/movie/list"
        case let .getMoviesBy(genreId):
            return "/movie/\(genreId)/lists"
        case .getPopular:
            return "/movie/popular"
        case let .getImages(movieId):
            return "/movie/\(movieId)/images"
        case let .getMovieDetail(id):
            return "/movie/\(id)"
        case let .getSimilarBy(movieId):
            return "/movie/\(movieId)/similar"
        case let .getVideosBy(movieId):
            return "/movie/\(movieId)/videos"
        case .getTopRated:
            return "/movie/top_rated"
        case .getUpcoming:
            return "/movie/upcoming"
        case .getLatest:
            return "/movie/latest"
        }
    }

    var parameters: Parameters? {
        return nil
    }

    var encoding: ParameterEncoding {
        switch method {
        default:
            return JSONEncoding.default
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try "\(Config.apiBaseUrl)\(path)?api_key=\(ConfigManager.apiKey.rawValue)".asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest = try encoding.encode(urlRequest, with: parameters)
        return urlRequest
    }
}

struct Config {
    static let apiBaseUrl = "https://api.themoviedb.org/3"
    static let apiImageBaseUrl = "https://image.tmdb.org/t/p/w500"
    static let apiYoutubeBaseUrl = "https://www.youtube.com/watch?v="
    static let apiVimeoBaseUrl = "https://vimeo.com/"
}
