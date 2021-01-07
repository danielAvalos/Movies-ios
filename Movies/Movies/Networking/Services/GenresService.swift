//
//  GenresService.swift
//  Movies
//
//  Created by DESARROLLO on 7/01/21.
//

import Alamofire

final class GenresService {

    func getGenresList(completionHandler: @escaping (GenresResponse?, ErrorModel?) -> Void) {
        Service.request(apiRouter: APIRouter.getGenresList,
                        completionHandler: completionHandler)
    }
}
