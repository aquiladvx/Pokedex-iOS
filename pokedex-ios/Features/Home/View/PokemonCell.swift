//
//  PokemonCell.swift
//  pokedex-ios
//
//  Created by Davi Aquila on 2022-06-18.
//

import SwiftUI
import Kingfisher

struct PokemonCell: View {
    
    var pokemon: Pokemon
    
    var body: some View {
        ZStack {
            HStack {
                Text(pokemon.name.capitalized)
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding(.top, 4)
                    .padding(.leading)
                
                Spacer()
                
                KFImage(URL(string: pokemon.imageUrl ?? ""))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 68, height: 68)
                    .padding([.bottom, .trailing], 4)
            }
            .background(Color.white)
            .cornerRadius(12)
            .frame(width: .infinity)
        }
    }
}

//struct PokemonCell_Previews: PreviewProvider {
//    static var previews: some View {
//        PokemonCell(pokemon: pokemon)
//            .background(Color.black)
//    }
//}
