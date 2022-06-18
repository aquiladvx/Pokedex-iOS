//
//  pokedex_iosApp.swift
//  pokedex-ios
//
//  Created by Davi Aquila on 2022-06-18.
//

import SwiftUI

@main
struct pokedex_iosApp: App {
    var body: some Scene {
        WindowGroup {
            let repository = HomeInteractor()
            let viewModel = HomeViewModel(dataSource: repository)
            HomeView(viewModel: viewModel)
        }
    }
}
