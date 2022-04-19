//
//  ConstantData.swift
//  Rahul_Gupta_Machine_Test
//
//  Created by Rahul Gupta on 23/03/22.
//

import Foundation
import SwiftUI

// Global Emum to distinguish Movies in the Tab view
enum MovieType : Int {
    // Tab element at 0 index
    case Popular  = 0
    // Tab element at 1 index
    case TopRated = 1
    
    // To show Title according to selected tab
    var title : String {
        switch self {
        case .Popular:
            return "Popular Movies"
        case .TopRated:
            return "Top Rated Movies"
        }
    }
}
