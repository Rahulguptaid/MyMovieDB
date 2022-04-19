//
//  Rahul_Gupta_Machine_TestApp.swift
//  Rahul_Gupta_Machine_Test
//
//  Created by Rahul Gupta on 23/03/22.
//

import SwiftUI

@main
struct Rahul_Gupta_Machine_TestApp: App {
    // Creating the PersistenceController for the environment
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
