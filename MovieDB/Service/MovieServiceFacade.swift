//
//  MovieServiceRepository.swift
//  MovieDB
//
//  Created by Alejandro Villa on 2/12/22.
//

import Foundation

protocol MovieServiceRepository {
    static func fetchTopRatedMovies() async throws -> MovieListResponse
}

struct MovieServiceFacade: MovieServiceRepository {
    
    static func fetchTopRatedMovies() async throws -> MovieListResponse {
        guard let url = URL(string: ServiceFlow.getTopRatedMovies.path) else {
            throw ServiceError.badUrl
        }
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(MovieListResponse.self, from: data)
        
        return response
    }
}
