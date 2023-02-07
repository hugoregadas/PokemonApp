//
//  PokedexObjectOutput.swift
//  PokemonApp
//
//  Created by Hugo Regadas on 19/12/2022.
//

import Foundation

struct PokemonSpeciesObject : Codable {
    let name : String
    let url : String
}

struct PokemonEntriesObjectOutput : Codable {
    let entry_number: Int
    let pokemon_species : PokemonSpeciesObject
}

struct PokedexObjectOutput : Codable {
    let pokemon_entries : [PokemonEntriesObjectOutput]
    
}
