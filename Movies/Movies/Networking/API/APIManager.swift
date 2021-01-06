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

    var method: HTTPMethod {
        switch self {
        case .getGenresList, .getMoviesByGenre:
            return .get
        }
    }

    var path: String {
        switch self {
        case .getGenresList:
            return "/api/v1/counters"
        case .getMoviesByGenre:
            return "/api/v1/counter"
        }
    }

    var parameters: Parameters? {
        switch self {
        case .getMoviesByGenre,
             .getGenresList:
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
        let url = try Config.apiBaseUrl.asURL().appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest = try encoding.encode(urlRequest, with: parameters)
        return urlRequest
    }
}

struct Config {
    static let apiBaseUrl = "https://api.themoviedb.org"
}
