//
//  ContentView.swift
//  MovieDB
//
//  Created by Alejandro Villa on 2/12/22.
//

import SwiftUI

struct LandingView: View {
    
    @ObservedObject var viewModel: LandingViewModel
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.genres) { genre in
                        Button(genre.name) {
                            viewModel.fetchMovies(for: genre)
                        }
                        .padding()
                        .background(Color(red: 0, green: 0, blue: 0.5))
                        .clipShape(Capsule())
                        .redacted(reason: viewModel.genres.isEmpty ? .placeholder : [])
                    }
                }
            }
            Spacer()
        }
        .task {
            viewModel.fetchAllGenres()
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView(
            viewModel: .init(
                genreService: GenreServiceFacade.self
            )
        )
    }
}
