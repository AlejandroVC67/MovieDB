//
//  ServiceFacade.swift
//  MovieDB
//
//  Created by Alejandro Villa on 2/12/22.
//

import Foundation

protocol GenreServiceRepository {
    static func fetchAllGenres() async throws -> MovieGenreResponse
    static func fetchMoviesBasedOn(genreId: Int) async throws -> MovieListResponse
}

struct GenreServiceFacade: GenreServiceRepository, ServiceRepository {
    static func fetchAllGenres() async throws -> MovieGenreResponse {
        guard let url = URL(string: ServiceFlow.getMovieGenres.path) else {
            throw ServiceError.badUrl
        }
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(MovieGenreResponse.self, from: data)
        
        return response
    }
    
    static func fetchMoviesBasedOn(genreId id: Int) async throws -> MovieListResponse {
        guard let url = URL(string: ServiceFlow.getMoviesOfGenre(id).path) else {
            throw ServiceError.badUrl
        }
        
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        let response = try JSONDecoder().decode(MovieListResponse.self, from: data)
        
        return response
    }
}
