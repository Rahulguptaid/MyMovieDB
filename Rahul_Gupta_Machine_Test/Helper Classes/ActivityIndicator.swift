//
//  ActivityIndicator.swift
//  Rahul_Gupta_Machine_Test
//
//  Created by Rahul Gupta on 24/03/22.
//

import Foundation
import SwiftUI

// Creating ActivityIndicator for the pagination in the Movies listing.
struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    var style: UIActivityIndicatorView.Style = .medium

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
