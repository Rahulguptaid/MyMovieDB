//
//  MovieResponseModel.swift
//  Rahul_Gupta_Machine_Test
//
//  Created by Rahul Gupta on 24/03/22.
//

import Foundation

struct MovieListResponseModel: APIModel {
    let page: Int?
    let results: [MovieModel]?
    let totalPages, totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MovieModel: Codable,Identifiable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalLanguage: String?
    let originalTitle, overview: String?
    let popularity: Double?
    let posterPath, releaseDate, title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    var imageURL : String {
        return NetworkManager.imageBaseURL+(posterPath ?? "")
    }
    var formatedReleaseDate : String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        guard let dateSer = dateFormater.date(from: releaseDate ?? "") else {
            return releaseDate ?? ""
        }
        dateFormater.dateFormat = "MMM dd, yyyy"
        return dateFormater.string(from: dateSer)
    }
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
