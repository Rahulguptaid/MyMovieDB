//
//  ApiEndPointManager.swift
//  Rahul_Gupta_Machine_Test
//
//  Created by Rahul Gupta on 24/03/22.
//

import Foundation

extension NetworkManager {
    func popularMovies(pageNum:Int, completion: @escaping ((Result<MovieListResponseModel,APIError>) -> Void)) {
        let param = [
            "api_key" : ApiKey,
            "page"    : pageNum == 0 ? 1 : pageNum
        ] as [String : Any]
        handleAPICalling(request: .popular(param: param), completion: completion)
    }
    func topRatedMovies(pageNum:Int, completion: @escaping ((Result<MovieListResponseModel,APIError>) -> Void)) {
        let param = [
            "api_key" : ApiKey,
            "page"    : pageNum == 0 ? 1 : pageNum
        ] as [String : Any]
        handleAPICalling(request: .topRated(param: param), completion: completion)
    }
    func movieVideos(movieID:Int, completion: @escaping ((Result<MovieListResponseModel,APIError>) -> Void)) {
        let param = [
            "api_key" : ApiKey
        ]
        handleAPICalling(request: .movieVideos(id: "\(movieID)", param: param), completion: completion)
    }
}


