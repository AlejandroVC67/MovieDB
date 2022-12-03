//
//  MovieServiceRepository.swift
//  MovieDB
//
//  Created by Alejandro Villa on 2/12/22.
//

import Foundation

struct MovieServiceClient {
    var fetchTopRatedMovies: () async throws -> MovieListResponse
}

extension MovieServiceClient {
    static let live = Self(
        fetchTopRatedMovies: {
            guard let url = URL(string: ServiceFlow.getTopRatedMovies.path) else {
                throw ServiceError.badUrl
            }
            
            let request = URLRequest(url: url)
            let (data, _) = try await URLSession.shared.data(for: request)
            let response = try JSONDecoder().decode(MovieListResponse.self, from: data)
            
            return response
        }
    )
    
    static var mock = Self(
        fetchTopRatedMovies: {
            .init(
                results: [
                    .init(id: 0, title: "test", popularity: 100.0)
                ]
            )
        }
    )
}
