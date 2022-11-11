//
//  ServiceManagerProtocol.swift
//  PokemonApp
//
//  Created by Hugo Regadas on 10/11/2022.
//

import Foundation


protocol ServiceManagerProtocol {
    func fetchPokedex(completion: @escaping (Result< [PokedexOutputList] , Error>) -> (Void))
}
