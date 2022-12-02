//
//  MovieServiceFacadeMock.swift
//  MovieDBTests
//
//  Created by Alejandro Villa on 2/12/22.
//

import Foundation
@testable import MovieDB

struct MovieServiceFacadeSuccessMock: MovieServiceRepository {

    static func fetchTopRatedMovies() async throws -> MovieDB.MovieListResponse {
        return .init(
            results: [
                .init(id: 0, title: "test", popularity: 100.0)
            ]
        )
    }
}
