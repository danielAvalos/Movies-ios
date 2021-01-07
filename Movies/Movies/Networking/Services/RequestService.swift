//
//  RequestService.swift
//  Movies
//
//  Created by DESARROLLO on 7/01/21.
//

import Foundation
import Alamofire

final class Service {

    static func request<T: Decodable>(apiRouter: APIRouter, completionHandler: @escaping (T?, ErrorModel?) -> Void) {
        let request = AF.request(apiRouter)
        request.responseDecodable(of: T.self) { (response) in
            guard let httpURLResponse = response.response else {
                completionHandler(nil, ErrorModel(code: .errorServer, descriptionLocalizable: response.error?.errorDescription))
                return
            }
            switch httpURLResponse.statusCode {
            case 200, 204:
                completionHandler(response.value, nil)
            case 401:
                completionHandler(nil, ErrorModel(code: .notAuthorized))
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
