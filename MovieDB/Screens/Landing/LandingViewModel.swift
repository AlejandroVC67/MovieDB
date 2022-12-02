//
//  LandingViewModel.swift
//  MovieDB
//
//  Created by Alejandro Villa on 2/12/22.
//

import Foundation

class LandingViewModel {
    
    private let service: ServiceRepository.Type
    private(set) var genres: [MovieGenre] = []
    
    
    init(service: ServiceRepository.Type) {
        self.service = service
    }
    
    func fetchMovieGenres() {
        service.execute(for: .getMovieGenres) { [unowned self] (response: Result<MovieGenreResponse, ServiceError>) in
            switch response {
            case .success(let response):
                self.genres = response.genres
                print(self.genres)
            case .failure(let error): print(error)
            }
        }
    }
}
