//
//  HomeView.swift
//  pokedex-ios
//
//  Created by Davi Aquila on 2022-06-18.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel: HomeViewModel
    @State var action: Int? = 0
    @State var navigationHidden = true
    
    var body: some View {
        Group {
            switch viewModel.uiState {
                case .none:
                    Text("none")
                case .loading:
                    Text("loading")
                case .error(errorMessage: let errorMessage):
                    Text(errorMessage)
                case .onResult(data: let data):
                    homePage(pokemons: data.results)
                    
            }
        }.onAppear(perform: viewModel.onAppear)
    }
}

extension HomeView {
    func homePage(pokemons: [Pokemon]) -> some View {
        NavigationView {
            List(pokemons, id: \.id) { pokemon in
                ZStack {
                    NavigationLink(
                        destination:
                            viewModel.goToPokemonDetail(pokemon: pokemon)) {
                                PokemonCell(pokemon: pokemon)
                            }
                }
                
            }.navigationTitle("Pokemons");
        }
        
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel(dataSource: HomeInteractor()))
    }
}
