//
//  PokemonDetailUIState.swift
//  pokedex-ios
//
//  Created by Davi Aquila on 2022-06-19.
//

import Foundation

enum PokemonDetailUIState {
    case none
    case loading
    case error(errorMessage: String)
    case onResult
}
