//
//  ContentView.swift
//  MovieDB
//
//  Created by Alejandro Villa on 2/12/22.
//

import SwiftUI

struct LandingView: View {
    
    let viewModel: LandingViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }.onAppear {
            viewModel.fetchMovieGenres()
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView(
            viewModel: .init(
                service: ServiceFacade.self
            )
        )
    }
}
