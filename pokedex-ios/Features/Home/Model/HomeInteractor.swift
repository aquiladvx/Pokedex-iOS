//
//  HomeRepository.swift
//  pokedex-ios
//
//  Created by Davi Aquila on 2022-06-18.
//

import Foundation
import Combine

class HomeInteractor {
    
    private let remote: RemoteDataSource = .shared
//    private let local
    
    func fetchAllPokemons() -> Future<PokemonsResponse, AppError> {
        return remote.fetchAllPokemons()
    }
}
