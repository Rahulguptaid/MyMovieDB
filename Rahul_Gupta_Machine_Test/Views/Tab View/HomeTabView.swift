//
//  HomeTabView.swift
//  Rahul_Gupta_Machine_Test
//
//  Created by Rahul Gupta on 23/03/22.
//

import SwiftUI

struct HomeTabView: View {
    init() {
        // Setting the TabBar bar background color white
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    // Storing the current active tab type in this state
    @State private var selectedType = MovieType.Popular
    var body: some View {
        NavigationView {
            TabView(selection: $selectedType) {
                MoviesListView(type: .Popular)
                    .tabItem {
                        Label("Popular", systemImage: "list.number")
                    }.tag(MovieType.Popular) //Setting custom tag to Tab Item
                
                MoviesListView(type: .TopRated)
                    .tabItem {
                        Label("Top Rated", systemImage: "list.number")
                    }.tag(MovieType.Popular)
            }
            .navigationTitle("Movies")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HomeTabView_Previews: PreviewProvider {
    static var previews: some View {
        HomeTabView()
    }
}
