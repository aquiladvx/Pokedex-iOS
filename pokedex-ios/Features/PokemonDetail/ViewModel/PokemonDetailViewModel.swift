//
//  PokemonDetailViewModel.swift
//  pokedex-ios
//
//  Created by Davi Aquila on 2022-06-19.
//

import SwiftUI
import Combine

class PokemonDetailViewModel: ObservableObject {
    @Published var uiState: PokemonDetailUIState = .none
    @Published var pokemon: Pokemon? = nil
    @Published var pokemonDetail: PokemonDetail? = nil
    
    var dataSource: PokemonDetailInteractor
    
    private var cancellable: [AnyCancellable?] = []
    
    init(dataSource: PokemonDetailInteractor) {
        self.dataSource = dataSource
    }
    
    deinit {
        cancellable.forEach { promise in
            promise?.cancel()
        }
    }
    
    func onAppear(pokemon: Pokemon) {
        self.pokemon = pokemon
        fetchPokemonDetail()
    }
}

extension PokemonDetailViewModel {
    func fetchPokemonDetail() {
        uiState = .loading
        
        let promise = dataSource.fetchPokemonDetail(pokemonId: self.pokemon!.id)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch (completion) {
                    case .failure(let appError):
                        self.uiState = .error(errorMessage: appError.message)
                    case .finished:
                        break
                }
            } receiveValue: { data in
                self.pokemonDetail = data
                self.uiState = .onResult
            }
        cancellable.append(promise)
    }
}
