//
//  ServiceFacade.swift
//  MovieDB
//
//  Created by Alejandro Villa on 2/12/22.
//

import Foundation

struct ServiceFacade: ServiceRepository {
    
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
