//
//  PlayTrailerView.swift
//  Rahul_Gupta_Machine_Test
//
//  Created by Rahul Gupta on 24/03/22.
//

import SwiftUI
import AVKit

struct PlayTrailerView: View {
    var body: some View {
        // Craeting a player view to ley video
        VideoPlayer(player: AVPlayer(url:  URL(string: "https://bit.ly/swswift")!))
            .transition(.move(edge: .bottom))
            .edgesIgnoringSafeArea(.all)
            
    }
}

struct PlayTrailerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayTrailerView()
    }
}
