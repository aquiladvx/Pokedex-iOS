//
//  PokemonDetail.swift
//  pokedex-ios
//
//  Created by Davi Aquila on 2022-06-19.
//

import Foundation

struct PokemonDetail: Decodable, Identifiable {
    let id: Int
    let name: String
    let weight: Int
    let height: Int
    var imageUrl: URL {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }
//    let types: Types
    
}

struct Types: Decodable {
    let slot: Int
    let type: [`Type`]
}

struct `Type`: Decodable {
    let name: String
    let url: String
}
