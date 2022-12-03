//
//  Environment.swift
//  MovieDB
//
//  Created by Alejandro Villa on 2/12/22.
//

import Foundation

struct Environment {
    var service: ServiceClient
}

var environment: Environment = .live

extension Environment {
    static let live = Self(
        service: .live
    )
    
    static var mock = Self(
        service: .mock
    )
}

struct ServiceClient {
    var moviesClient: MovieServiceClient
    var genresClient: GenreServiceClient
}

extension ServiceClient {
    static let live = Self(
        moviesClient: .live,
        genresClient: .live
    )
    
    static var mock = Self(
        moviesClient: .mock,
        genresClient: .mock
    )
}
