//
//  MoviesServices.swift
//  Movies
//
//  Created by DESARROLLO on 6/01/21.
//

import Alamofire

final class MoviesService {

    func getGenresList(completionHandler: @escaping ([GenreModel]?, ErrorModel?) -> Void) {
        request(apiRouter: APIRouter.getGenresList, completionHandler: completionHandler)
    }

    private func request(apiRouter: APIRouter, completionHandler: @escaping ([GenreModel]?, ErrorModel?) -> Void) {
        let request = AF.request(apiRouter)
        request.responseDecodable(of: [GenreModel].self) { (response) in
            guard let httpURLResponse = response.response else {
                completionHandler(nil, ErrorModel(code: .errorServer, descriptionLocalizable: response.error?.errorDescription))
                return
            }
            switch httpURLResponse.statusCode {
            case 200, 204:
                completionHandler(response.value, nil)
            case 400:
                completionHandler(nil, ErrorModel(code: .badRequest))
            case 404:
                completionHandler(nil, ErrorModel(code: .notFound))
            case 500:
                completionHandler(nil, ErrorModel(code: .errorServer))
            default:
                completionHandler(nil, ErrorModel(code: .unknown))
            }
        }
    }

}
