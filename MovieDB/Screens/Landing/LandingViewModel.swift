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
    
    private let genreService: GenreServiceRepository.Type
    private let movieService: MovieServiceRepository.Type
    
    init(
        genreService: GenreServiceRepository.Type,
        movieService: MovieServiceRepository.Type
    ) {
        self.genreService = genreService
        self.movieService = movieService
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
    
    func fetchTopRatedMovies() {
        Task {
            do {
                let response = try await movieService.fetchTopRatedMovies()
                self.movies = response.results
                print(movies)
            } catch let error {
                print(error)
            }
        }
    }
}
