//
//  FilteredList.swift
//  Rahul_Gupta_Machine_Test
//
//  Created by iOS TL on 24/03/22.
//

import SwiftUI
import CoreData
// Craeted Genric List View to filtered the Fetchresult data coming from the Local Storage
struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>

    // this is our content closure; we'll call this once for each item in the list
    let content: (T) -> Content

    var body: some View {
        List(fetchRequest, id: \.self) { singer in
            self.content(singer)
        }.listStyle(GroupedListStyle()) // Showing List in the Group Style view
            .frame(height:(CGFloat(fetchRequest.count)*50) + 60)
    }

    init(filterKey: String, filterValue: Int32, @ViewBuilder content: @escaping (T) -> Content) {
        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K == %d", filterKey, filterValue))
        self.content = content
    }
}
