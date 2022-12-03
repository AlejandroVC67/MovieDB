//
//  LadingVIewModelTests.swift
//  MovieDBTests
//
//  Created by Alejandro Villa on 2/12/22.
//

import XCTest
@testable import MovieDB

@MainActor
final class LandingVIewModelTests: XCTestCase {
    
    func testFetchAllGenres_givenSuccessMock_shouldReturnGenres() async {
        // Given
        let viewModel = LandingViewModel(environment: .mock)
        
        // When
        await viewModel.fetchAllGenres()
        
        // Then
        XCTAssertFalse(viewModel.genres.isEmpty, "Genres should not be empty.")
    }
    
    func testFetchMoviesForGenre_givenSuccessMock_shouldReturnMovies() async {
        // Given
        let viewModel = LandingViewModel(environment: .mock)
        let genre = MovieGenre(id: 1, name: "test")
        
        // When
        await viewModel.fetchMovies(for: genre)
        
        // Then
        XCTAssertFalse(viewModel.movies.isEmpty, "Movies should not be empty.")
    }
    
    func testFetchTopRatedMovies_givenSuccessMock_shouldReturnMovies() async {
        // Given
        let viewModel = LandingViewModel(environment: .mock)
        
        // When
        await viewModel.fetchTopRatedMovies()
        
        // Then
        XCTAssertFalse(viewModel.movies.isEmpty, "Movies should not be empty.")
    }
}
