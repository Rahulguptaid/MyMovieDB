//
//  OnRefreshModifier.swift
//  Rahul_Gupta_Machine_Test
//
//  Created by Rahul Gupta on 23/03/22.
//
import UIKit

enum NetworkEnvironment : String {
    case development  = "https://api.themoviedb.org/3"
}
enum BaseURL : String {
    case image  = "https://image.tmdb.org/t/p/w500"
}
enum APIEndPoint {
    case popular(param:[String:Any])
    case topRated(param:[String:Any])
    case movieVideos(id:String,param:[String:Any])
}
extension APIEndPoint:EndPointType {
    var environmentBaseURL : String {
        return NetworkManager.environment.rawValue
    }
    var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    var path: String {
        switch  self {
        case .popular:
            return "/movie/popular"
        case .topRated:
            return "/movie/top_rated"
        case .movieVideos(id: let id, _):
            return "/movie/\(id)/videos"
        }
    }
    var httpMethod: HTTPMethod {
        return .post
    }
    var task: HTTPTask {
        switch self {
        case .popular(param: let param):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: param)
        case .topRated(param: let param):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: param)
        case .movieVideos(_ , param: let param):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: param)
        }
    }
    var headers: HTTPHeaders? {
        return nil
    }
}
