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
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.genres) { genre in
                            Button(genre.name) {
                                Task {
                                    await viewModel.fetchMovies(for: genre)
                                }
                            }
                            .padding()
                            .redacted(reason: viewModel.genres.isEmpty ? .placeholder : []) // Revisit
                        }
                    }
                    .padding()
                }
                
                List(viewModel.movies) { movie in
                    NavigationLink {
                        // TODO: Movie Detail
                    } label: {
                        Text(movie.title)
                            .redacted(reason: viewModel.genres.isEmpty ? .placeholder : []) // Revisit
                    }
                }
            }
        }
        .task {
            await viewModel.fetchAllGenres()
            await viewModel.fetchTopRatedMovies()
        }
    }
}

struct LandingView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView(
            viewModel: .init(
                genreService: GenreServiceFacade.self,
                movieService: MovieServiceFacade.self
            )
        )
    }
}
