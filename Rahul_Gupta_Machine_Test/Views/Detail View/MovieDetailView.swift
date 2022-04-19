//
//  MovieDetailView.swift
//  Rahul_Gupta_Machine_Test
//
//  Created by Rahul Gupta on 23/03/22.
//

import SwiftUI
struct MovieDetailView: View {
    // Managing core data for thwe comments
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MovieComment.movieID, ascending: true)],
        animation: .default)
    private var items: FetchedResults<MovieComment>
    // Selected mobvie data from the previus page
    let movieData : MovieModel
    
    init(movie:MovieModel,viewModel:MovieTabsViewModel) {
        movieData = movie
        // Setting tableView appreance
        UITableView.appearance().backgroundColor     = .clear
        UITableViewCell.appearance().selectionStyle  = .none
        UITableView.appearance().tableHeaderView     = UIView()
        UITableView.appearance().sectionHeaderHeight = 0
        UITableView.appearance().sectionFooterHeight = 0
    }
    // Storing the current user comment
    @State private var userComment = String()
    // Opening the player when user click on the Watch tailor
    @State private var isPlayTrailer = Bool()
    var body: some View {
        KeyboardView {
            ScrollView {
                VStack {
                    // Showing movie poster asyn image
                    AsyncImage(url:  URL(string: movieData.imageURL)!,
                               placeholder: { Image("SampleImage") }, image: { Image(uiImage: $0).resizable() }).frame(width: 200, height: 200, alignment: .center)
                        .cornerRadius(12)
                    Text(movieData.title ?? "Title")
                        .font(.largeTitle)
                    Text(movieData.overview ?? "Description")
                        .padding(.horizontal)
                        .multilineTextAlignment(.center)
                    // Watch tailor battor
                    Button {
                        // Toggel state to open Sheet from this view
                        isPlayTrailer.toggle()
                    } label: {
                        Text("Watch Trailer")
                        Image(systemName: "play.circle")
                    }.padding(5)
                    Text("Comment")
                        .font(.headline)
                    // This code is filetering comment account to current movie id.
                    FilteredList(filterKey: "movieID", filterValue: Int32(movieData.id ?? 0)) { (movie: MovieComment) in
                        Text(movie.comment ?? "Not Given")
                    }
                    HStack() {
                        TextEditor(text: $userComment).border(.gray, width: 1)
                            .frame(height: 70)
                        Button {
                            if !userComment.isEmpty {
                                addComment()
                            }
                        } label: {
                            Image(systemName: "paperplane.fill")
                        }.padding(.horizontal)
                    }.padding(.horizontal)
                }.padding(.vertical)
            }.sheet(isPresented: $isPlayTrailer) {
                // Openig Player view
                PlayTrailerView()
            }
        } toolBar: {
            // handing the Keyboard Toolbar to mange its hide
            HStack {
                Spacer()
                Button(action: {
                    // Hide keyboard when user clik on the hide button from tool bar
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }, label: {
                    Text("Done")
                })
            }.padding()
        }
    }
    private func addComment() {
        withAnimation {
            // Saving comment to core data with movie id
            let newItem = MovieComment(context: viewContext)
            newItem.movieID = Int32(movieData.id ?? 0)
            newItem.comment = userComment
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
            userComment = ""
        }
    }
}
