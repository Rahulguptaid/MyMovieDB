//
//  MoviesListView.swift
//  Rahul_Gupta_Machine_Test
//
//  Created by Rahul Gupta on 23/03/22.
//

import SwiftUI
import AlertToast
struct MoviesListView: View {
    // Fetching environment object of coredata to save and fetch movie list in ofline
    @Environment(\.managedObjectContext) var viewContext
    // Genrate fetch request for Movies Entity and sort data according to Id
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Movies.id, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Movies> // Storing Fetch result from Movies table
    // Computed properties for genrating the Local Movies list accoring to selected type
    private var localMovies : [MovieModel] {
        let filteredArray = items.filter { mov in
            mov.type == viewType.title
        }
           return filteredArray.compactMap({ data in
               MovieModel(adult: false, backdropPath: "", genreIDS: [], id: Int(data.id), originalLanguage: "", originalTitle: "", overview: data.overview, popularity: 0, posterPath: data.posterPath, releaseDate: data.releaseDate, title: data.title, video: false, voteAverage: 0, voteCount: 0)})
    }
    // Store current class type i.e., Popular or Top Rated
    let viewType : MovieType
    // View Model for handling Data or Api related task
    @ObservedObject var movieViewModel : MovieTabsViewModel
        
    init(type:MovieType) {
        viewType = type
        // Initialising viewModel according to selected tab type
        movieViewModel = MovieTabsViewModel(type: type)
        // Setting list appreance like removing ist background color
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().selectionStyle = .none
    }
    var body: some View {
        ZStack {
            Color.appBackground.ignoresSafeArea()
            List {
                // Showing list if it have either local data or Server data
                ForEach(self.movieViewModel.movies.isEmpty ? localMovies : self.movieViewModel.movies) { movie in
                    NavigationLink(destination: MovieDetailView(movie: movie, viewModel: movieViewModel)) {
                        // Creating Cell for the according to movie detail
                        MoviesCellView(movie: movie)
                    }
                }
                // Thiis code is responsible for Paginnation
                if !self.movieViewModel.movieListFull {
                    // If user scroll to bottom it show indicator and call the api by increasing Current page by 1
                    ActivityIndicator(isAnimating: .constant(true))
                    .onAppear {
                        movieViewModel.currentPage += 1
                        // Call Api from the viewmodel
                        movieViewModel.fetchMovies()
                        // Property observer when Api response completed
                        movieViewModel.didFinishFetch = {
                            // updating Local database
                            updateLocalDatabase()
                        }
                    }
                }
                //This code is responsible for pull to re refresh
            }.onRefresh { refreshControl in
                // it aging Call the api by seing page num 1
                movieViewModel.currentPage = 1
                movieViewModel.fetchMovies()
                movieViewModel.didFinishFetch = {
                    refreshControl.endRefreshing()
                    updateLocalDatabase()
                }
            }
            // For showing toast on the screen. This toast is being handled be Viewmodel it published error to the toast to show
            .toast(isPresenting: $movieViewModel.showAlert){
                AlertToast(displayMode: .banner(.slide), type: .regular, title: movieViewModel.error ?? "Server Error!")
            }
            
        }.onAppear {
            // Call the api when user enter this screen
            movieViewModel.fetchMovies()
            // Property observer when Api response completed
            movieViewModel.didFinishFetch = {
                updateLocalDatabase()
            }
        }
    }
    // Updating Local data base when ever api response completed
    private func updateLocalDatabase() {
        // Fetch all the list from the view model and update local data base
        for data in movieViewModel.movies{
            let newMoview = Movies(context: self.viewContext)
            newMoview.id = Int32(data.id ?? 0)
            newMoview.title = data.title ?? ""
            newMoview.overview = data.overview ?? ""
            newMoview.releaseDate = data.releaseDate ?? ""
            newMoview.posterPath  = data.posterPath ?? ""
            newMoview.type        = viewType.title
            do {
                try self.viewContext.save()
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView(type: .Popular)
    }
}
