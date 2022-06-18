//
//  Pokemon.swift
//  pokedex-ios
//
//  Created by Davi Aquila on 2022-06-18.
//

import Foundation

struct PokemonsResponse : Codable {
    var results: [Pokemon]
}

class Pokemon: Codable, Identifiable {
    let id = UUID()
    var name: String
    var url: String
    var imageUrl: String? = nil
}
