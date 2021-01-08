//
//  APIManager.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import Alamofire

enum APIRouter: URLRequestConvertible {

    case getGenresList
    case getMoviesByGenre(id: Int)
    case getPopular
    case getImages(movieId: Int)

    var method: HTTPMethod {
        switch self {
        case .getGenresList,
             .getMoviesByGenre,
             .getImages,
             .getPopular:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getGenresList:
            return "/genre/movie/list?api_key=\(ConfigManager.apiKey.rawValue)"
        case let .getMoviesByGenre(id):
            return "/movie/\(id)/lists?api_key=\(ConfigManager.apiKey.rawValue)"
        case .getPopular:
            return "/movie/popular?api_key=\(ConfigManager.apiKey.rawValue)"
        case let .getImages(movieId):
            return "/movie/\(movieId)/images"
        }
    }

    var parameters: Parameters? {
        switch self {
        case .getMoviesByGenre,
             .getGenresList,
             .getPopular,
             .getImages:
            return nil
        }
    }

    var encoding: ParameterEncoding {
        switch method {
        default:
            return JSONEncoding.default
        }
    }

    func asURLRequest() throws -> URLRequest {
        let url = try "\(Config.apiBaseUrl)\(path)".asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest = try encoding.encode(urlRequest, with: parameters)
        return urlRequest
    }
}

struct Config {
    static let apiBaseUrl = "https://api.themoviedb.org/3"
}
