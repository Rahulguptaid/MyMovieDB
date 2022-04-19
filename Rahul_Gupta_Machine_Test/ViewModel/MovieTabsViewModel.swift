//
//  MovieTabsViewModel.swift
//  Rahul_Gupta_Machine_Test
//
//  Created by Rahul Gupta on 24/03/22.
//

import Foundation
import Combine
import CoreData
import SwiftUI
// View Model class for Movie list
class MovieTabsViewModel: ObservableObject {
    private var modelType : MovieType
    // Publishing the movie to view
    @Published var movies = [MovieModel]()
    
    // It store all the Populor Movies data only
    private var movies_Popuplar_List = [MovieModel]()
    // It store all the Top Rated Movies data only
    private var movies_TopRated_List = [MovieModel]()
    var movieListFull = false
    // Fetching and setting data accoding to current selected type of tab
    var currentPage : Int {
        set {
            switch modelType {
            case .Popular:
                currentPage_Popular  = newValue
            case .TopRated:
                currentPage_TopRated = newValue
            }
        }
        get {
            switch modelType {
            case .Popular:
                return currentPage_Popular
            case .TopRated:
                return currentPage_TopRated
            }
        }
    }
    private var currentPage_Popular  = 0
    private var currentPage_TopRated = 0
    // this published variable showing Toast on view
    @Published var showAlert =  Bool()
    // Poperty closure for handling loading status on view
    @Published var updateLoadingStatus: (() -> ())?
    // Poperty closure for handling Api call finshed notification on view
    @Published var didFinishFetch: (() -> ())?

    //API related Variable
    var error: String? {
        didSet { showAlert = true }
    }
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    init(type:MovieType) {
        modelType = type
    }
    func fetchMovies() {
        // Calling the api according to selected movie type
        switch modelType {
        case .Popular:
            if movieListFull {
                self.error = "Movie is fetched fully no more data left."
                self.didFinishFetch?()
                return
            }
            isLoading = true
            let model = NetworkManager.sharedInstance
            model.popularMovies(pageNum: currentPage) { [weak self](result) in
                guard let self = self else {return}
                self.isLoading = false
                switch result{
                case .success(let res):
                    // Appending data to existing Movies data array
                    self.movies_Popuplar_List.append(contentsOf: res.results ?? [])
                    self.movies = self.movies_Popuplar_List
                    if res.totalPages ?? 0 == self.currentPage {
                        // hadling the movie list is fetch fully
                        self.movieListFull = true
                    }
                    self.didFinishFetch?()
                case .failure(let err):
                    switch err {
                    case .errorReport(let desc):
                        self.error = desc
                        print(desc)
                    }
                    self.didFinishFetch?()
                }
            }
        case .TopRated:
            isLoading = true
            if movieListFull {
                self.error = "Movie is fetched fully no more data left."
                self.didFinishFetch?()
                return
            }
            let model = NetworkManager.sharedInstance
            model.topRatedMovies(pageNum: currentPage) { [weak self](result) in
                guard let self = self else {return}
                self.isLoading = false
                switch result{
                case .success(let res):
                    self.movies_TopRated_List.append(contentsOf: res.results ?? [])
                    self.movies = self.movies_TopRated_List
                    if res.totalPages ?? 0 == self.currentPage {
                        self.movieListFull = true
                    }
                    self.didFinishFetch?()
                case .failure(let err):
                    switch err {
                    case .errorReport(let desc):
                        self.error = desc
                        print(desc)
                    }
                    self.didFinishFetch?()
                }
            }
        }
    }
}
