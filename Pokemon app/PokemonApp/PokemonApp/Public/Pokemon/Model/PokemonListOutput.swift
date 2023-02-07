//
//  PokedexOutput.swift
//  PokemonApp
//
//  Created by Hugo Regadas on 10/11/2022.
//

import Foundation

struct PokemonResults : Codable {
    let name: String
    let url: String
}

struct PokemonListOutput : Codable {
    let count : Int
    let next : String
    let previous : String?
    let results : [PokemonResults]
}
