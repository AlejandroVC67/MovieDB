//
//  ServiceFacade.swift
//  MovieDB
//
//  Created by Alejandro Villa on 2/12/22.
//

import Foundation

struct GenreServiceClient {
    var fetchAllGenres: () async throws -> MovieGenreResponse
    var fetchMoviesBasedOn: (_ genreId: Int) async throws -> MovieListResponse
}

extension GenreServiceClient {
    static let live = Self(
        fetchAllGenres: {
            guard let url = URL(string: ServiceFlow.getMovieGenres.path) else {
                throw ServiceError.badUrl
            }
            
            let request = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(MovieGenreResponse.self, from: data)
            
            return response
        },
        fetchMoviesBasedOn: {
            guard let url = URL(string: ServiceFlow.getMoviesOfGenre($0).path) else {
                throw ServiceError.badUrl
            }
            
            let request = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(MovieListResponse.self, from: data)
            
            return response
        }
    )
    
    static var mock = Self(
        fetchAllGenres: {
            .init(
                genres: [
                    .init(id: 1, name: "Test genre")
                ]
            )
        },
        fetchMoviesBasedOn: { _ in
            .init(
                results: [
                    .init(id: 1, title: "Test movie", popularity: 100.5)
                ]
            )
        }
    )
}
