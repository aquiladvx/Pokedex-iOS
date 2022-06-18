//
//  HomeViewModel.swift
//  pokedex-ios
//
//  Created by Davi Aquila on 2022-06-18.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    @Published var uiState: HomeUIState = .none
    var dataSource: HomeInteractor
    
    private var cancellable: [AnyCancellable?] = []
    
    init(dataSource: HomeInteractor) {
        self.dataSource = dataSource
    }
    
    deinit {
        cancellable.forEach { promise in
            promise?.cancel()
        }
    }
    
    func onAppear() {
        fetchAllPokemons()
    }
    
}

extension HomeViewModel {
    func fetchAllPokemons() {
        uiState = .loading
        let promise = dataSource.fetchAllPokemons()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch (completion) {
                    case .failure(let appError):
                        self.uiState = .error(errorMessage: appError.message)
                    case .finished:
                        break
                }
            } receiveValue: { data in
                self.mountPokemonImages(data: data)
            }
        cancellable.append(promise)
    }
     
    func mountPokemonImages(data: PokemonsResponse) {
        data.results.forEach { pokemon in
            let number = pokemon.url.split(separator: "/").last!
            pokemon.imageUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(number).png"
        }
        
        data.results.forEach { pokemon in
            print(pokemon.imageUrl ?? "EMPTY")
        }
        self.uiState = .onResult(data: data)
        
    }
}

