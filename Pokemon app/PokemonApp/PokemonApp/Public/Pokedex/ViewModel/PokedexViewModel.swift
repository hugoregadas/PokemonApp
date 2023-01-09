//
//  PokedexViewModel.swift
//  PokemonApp
//
//  Created by Hugo Regadas on 19/12/2022.
//

import Foundation

class PokedexViewModel{
    //MARK: - Private
    private var serviceAPI: ServiceManager
    private var pokedexSelected : PokedexOutputList
    private var allPokemons : PokedexObjectOutput?
    
    init(serviceAPI: ServiceManager, pokedexSelected : PokedexOutputList) {
        self.serviceAPI = serviceAPI
        self.pokedexSelected = pokedexSelected
    }
}

//MARK: - Public Methods
extension PokedexViewModel {
    func fetchPokedexInfo(completion: @escaping ()->(Void)) {
        serviceAPI.fetchPokedexInfo(with: pokedexSelected.url) { result in
            switch result {
            case .success(let pokedex):
                self.allPokemons = pokedex
                completion()
                break
            case .failure(let error):
                NSLog(error.localizedDescription)
                completion()
                break
            }
        }
        
    }
    
    func getNumberOfPokemons() -> Int {
        guard let allPokemons = allPokemons else {
            return 0
        }
        
        return allPokemons.pokemon_entries.count
    }
    
    func getPokemonInfo(with row: Int) -> String{
        guard let allPokemons = allPokemons else {
            return "Empty List"
        }
        
        let name = allPokemons.pokemon_entries[row].pokemon_species.name
        let number = allPokemons.pokemon_entries[row].entry_number
        
        return "\(number)" + " - " + name
        
    }
}


