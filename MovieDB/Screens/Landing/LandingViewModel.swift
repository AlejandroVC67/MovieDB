//
//  LandingViewModel.swift
//  MovieDB
//
//  Created by Alejandro Villa on 2/12/22.
//

import Foundation

@MainActor
class LandingViewModel: ObservableObject {
    
    private let genreService: GenreServiceRepository.Type
    @Published private(set) var genres: [MovieGenre] = []
    @Published private(set) var movies: [Movie] = []
    
    init(genreService: GenreServiceRepository.Type) {
        self.genreService = genreService
    }
    
    func fetchAllGenres() {
        Task {
            do {
                let response = try await genreService.fetchAllGenres()
                self.genres = response.genres
                print(self.genres)
            } catch let error {
                print(error)
            }
        }
    }
    
    func fetchMovies(for genre: MovieGenre) {
        Task {
            do {
                let response = try await genreService.fetchMoviesBasedOn(genreId: genre.id)
                self.movies = response.results
                print(self.movies)
            } catch let error {
                print(error)
            }
        }
    }
}
