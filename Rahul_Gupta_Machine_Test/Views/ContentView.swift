//
//  ContentView.swift
//  Rahul_Gupta_Machine_Test
//
//  Created by Rahul Gupta on 23/03/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // using this state for presenting TabBar
    @State private var showHome = Bool()
    var body: some View {
        ZStack {
            //Show tite for approx 2 sec
            Text("Movies")
                .font(.largeTitle)
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                // Toggle state to present tabbar view
                showHome.toggle()
            }
        }
        // Presenting the TabBar from the content view
        .fullScreenCover(isPresented: $showHome,content: {
            HomeTabView() // Tabbar View
        })
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
