//
//  HomeUIState.swift
//  pokedex-ios
//
//  Created by Davi Aquila on 2022-06-18.
//

import Foundation

enum HomeUIState {
    case none
    case loading
    case error(errorMessage: String)
    case onResult(data: PokemonsResponse)
}
