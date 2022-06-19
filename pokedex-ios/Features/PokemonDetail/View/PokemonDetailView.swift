//
//  PokemonDetailView.swift
//  pokedex-ios
//
//  Created by Davi Aquila on 2022-06-19.
//

import SwiftUI
import Kingfisher

struct PokemonDetailView: View {
    
    @ObservedObject var viewModel: PokemonDetailViewModel
    var pokemon: Pokemon
    
    var body: some View {
        Group {
            switch viewModel.uiState {
                case .none:
                    Text("none")
                case .loading:
                    Text("loading")
                case .error(errorMessage: let errorMessage):
                    Text(errorMessage)
                case .onResult:
                    pokemonDetailPage
                    
                    
            }
        }.onAppear {
            viewModel.onAppear(pokemon: pokemon)
        }
    }
}

extension PokemonDetailView {
    var pokemonDetailPage: some View {
        ZStack {
            VStack {
                KFImage(viewModel.pokemonDetail!.imageUrl)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .padding([.bottom, .trailing], 4)
                
                Text(viewModel.pokemonDetail!.name.capitalized)
                    .font(.title)
            }
        }
    }
}

//struct PokemonDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PokemonDetailView()
//    }
//}
