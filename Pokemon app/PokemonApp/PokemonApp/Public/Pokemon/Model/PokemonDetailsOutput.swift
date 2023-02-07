//
//  PokemonDetailsOutput.swift
//  PokemonApp
//
//  Created by Hugo Regadas on 11/01/2023.
//

import Foundation

struct Sprites : Codable {
    let front_default : String
}

struct Species : Codable {
    let name : String
    let url : String
}


struct PokemonDetailsOutput : Codable {
    let species : Species
    let sprites : Sprites
    let order : Int
    let name : String
}
