//
//  Pokemon.swift
//  pokedex-ios
//
//  Created by Davi Aquila on 2022-06-18.
//

import Foundation

struct PokemonsResponse : Decodable {
    var results: [Pokemon]
}

class Pokemon: Decodable, Identifiable {
    var name: String
    var url: String
    var id: Int {
        Int(String(url.split(separator: "/").last!))!
    }
    var imageUrl: URL {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(id).png")!
    }
}
