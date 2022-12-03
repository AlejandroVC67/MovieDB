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
                            .redacted(reason: viewModel.genres.isEmpty ? .placeholder : [])
                        }
                    }
                    .padding()
                }
                
                List(viewModel.movies) { movie in
                    NavigationLink {
                        // TODO: Movie Detail
                    } label: {
                        Text(movie.title)
                            .redacted(reason: viewModel.movies.isEmpty ? .placeholder : [])
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
//        let environment: Environment = .init(
//            service: .init(
//                moviesClient: .init(
//                    fetchTopRatedMovies: {
//                        .init(results: [])
//                    }
//                ),
//                genresClient: .init(
//                    fetchAllGenres: { .init(genres: []) },
//                    fetchMoviesBasedOn: { _ in .init(results: []) }
//                )
//            )
//        )
        return LandingView(
            viewModel: .init(environment: .live)
        )
    }
}
