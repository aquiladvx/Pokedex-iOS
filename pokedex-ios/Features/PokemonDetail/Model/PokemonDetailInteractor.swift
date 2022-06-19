//
//  PokemonDetailInteractor.swift
//  pokedex-ios
//
//  Created by Davi Aquila on 2022-06-19.
//

import Foundation
import Combine

class PokemonDetailInteractor {
    
    private let remote: PokemonDataSource = .shared
    
    
    func fetchPokemonDetail(pokemonId: Int) -> Future<PokemonDetail, AppError> {
        return remote.fetchPokemonDetail(pokemonId: pokemonId)
    }
}
