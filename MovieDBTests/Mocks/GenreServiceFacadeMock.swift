//
//  GenreServiceFacadeMock.swift
//  MovieDBTests
//
//  Created by Alejandro Villa on 2/12/22.
//

import Foundation
@testable import MovieDB

struct GenreServiceFacadeSuccessMock: GenreServiceRepository {
    static func fetchAllGenres() async throws -> MovieDB.MovieGenreResponse {
        return .init(
            genres: [
                .init(id: 1, name: "Test genre")
            ]
        )
    }
    
    static func fetchMoviesBasedOn(genreId: Int) async throws -> MovieDB.MovieListResponse {
        return .init(
            results: [
                .init(id: 1, title: "Test movie", popularity: 100.5)
            ]
        )
    }
}
