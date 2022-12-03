//
//  LandingViewModel.swift
//  MovieDB
//
//  Created by Alejandro Villa on 2/12/22.
//

import Foundation

@MainActor
class LandingViewModel: ObservableObject {
    
    @Published private(set) var genres: [MovieGenre] = []
    @Published private(set) var movies: [Movie] = []
    
    private let environment: Environment
    
    init(
        environment: Environment = .live
    ) {
        self.environment = environment
    }
    
    func fetchAllGenres() async {
        do {
            let response = try await environment.service.genresClient.fetchAllGenres()
            self.genres = response.genres
        } catch let error {
            print(error)
        }
    }
    
    func fetchMovies(for genre: MovieGenre) async {
        do {
            let response = try await environment.service.genresClient.fetchMoviesBasedOn(genre.id)
            self.movies = response.results
        } catch let error {
            print(error)
        }
    }
    
    func fetchTopRatedMovies() async {
        do {
            let response = try await environment.service.moviesClient.fetchTopRatedMovies()
            self.movies = response.results
        } catch let error {
            print(error)
        }
    }
}
