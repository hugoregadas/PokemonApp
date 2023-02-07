//
//  PokemonSpeciesDetailsOutput.swift
//  PokemonApp
//
//  Created by Hugo Regadas on 12/01/2023.
//

import Foundation

struct PokemonColor : Codable {
    let name : String
}

struct PokemonSpeciesDetailsOutput : Codable{
    let color : PokemonColor
}
