//
//  ServiceRepository.swift
//  MovieDB
//
//  Created by Alejandro Villa on 2/12/22.
//

import Foundation

enum ServiceFlow {
    private static let apiKey = "726fb84d50d8d38573f6d11b7e693a4f"
    
    case getMovieGenres
    case getMoviesOfGenre(Int)
    
    var path: String {
        switch self {
        case .getMovieGenres: return "https://api.themoviedb.org/3/genre/movie/list?api_key=\(Self.apiKey)"
        case .getMoviesOfGenre(let genreId): return "https://api.themoviedb.org/3/discover/movie?api_key=\(Self.apiKey)&with_genres=\(genreId)"
        }
    }
}

enum ServiceError: Error {
    case badUrl
    case serviceError(Error?)
    case serializationError
    
    var errorMessage: String {
        switch self {
        case .badUrl: return "The URL has a bad format"
        case .serviceError(let error): return "We had a service error: \(String(describing: error))"
        case .serializationError: return "Serialization error occur"
        }
    }
}


protocol ServiceRepository {
    static func execute<T>(for flow: ServiceFlow, completion: @escaping (Result<T, ServiceError>) -> Void) where T: Codable
}

extension ServiceRepository {
    static func execute<T>(for flow: ServiceFlow, completion: @escaping (Result<T, ServiceError>) -> Void) where T : Decodable, T : Encodable {
        guard let url = URL(string: flow.path) else {
            completion(.failure(.badUrl))
            return
        }
        
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data else {
                completion(.failure(.serviceError(error)))
                return
            }
            
            guard let model = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.serializationError))
                return
            }
            
            completion(.success(model))
        }
        .resume()
    }
}

