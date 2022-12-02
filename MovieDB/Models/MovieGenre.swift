//
//  MovieGenre.swift
//  MovieDB
//
//  Created by Alejandro Villa on 2/12/22.
//

import Foundation

struct MovieGenreResponse: Codable {
    let genres: [MovieGenre]
}

struct MovieGenre: Codable {
    let id: Int
    let name: String
}
