//
//  MovieDBApp.swift
//  MovieDB
//
//  Created by Alejandro Villa on 2/12/22.
//

import SwiftUI

@main
struct MovieDBApp: App {
    var body: some Scene {
        WindowGroup {
            LandingView(
                viewModel: .init(
                    genreService: GenreServiceFacade.self
                )
            )
        }
    }
}
