//
//  PokedexOutput.swift
//  PokemonApp
//
//  Created by Hugo Regadas on 10/11/2022.
//

import Foundation

struct PokedexOutputList : Codable {
    let name: String
    let url: String
}

struct PokedexOutput : Codable {
    let count : Int
    let next : String
    let previous : String?
    let results : [PokedexOutputList]
}
