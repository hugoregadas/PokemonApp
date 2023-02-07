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
    private var allPokemonListCell: [PokemonCellViewModel] = []
    private var allPokemonListCellFilter : [PokemonCellViewModel] = []

    //MARK: - Public
    var isFilter = false

    init(serviceAPI: ServiceManager) {
        self.serviceAPI = serviceAPI
    }
}

//MARK: - Public Methods
extension PokedexViewModel {
    func fetchPokemonList(completion: @escaping ()->(Void)) {
        serviceAPI.fetchPokemonList("", completion: { [self] result in
            switch result {
            case .success(let pokemonList):
                createPokemonViewModel(newResults: pokemonList) {
                    completion()
                }
                break
            case .failure(_):
                completion()
                break
            }
        })
    }
    
    func fetchPokemon(with name : String , completion: @escaping ()-> (Void)){
        allPokemonListCellFilter = []
        serviceAPI.fetchPokemonAllDetailsWith(pokemonName: name) { result in
            switch result {
            case .success(let success):
                let model = PokemonCellViewModel(urlPokemon:"", isFilter: true, pokemon: success)
                self.allPokemonListCellFilter.append(model)
                completion()
                break
            case .failure(_):
                completion()
                break
            }
        }
    }
    
    func getNumberOfPokemons() -> Int {
        if isFilter {
            return allPokemonListCellFilter.count
        }else {
            return allPokemonListCell.count
        }
    }
    
    func getPokemonViewModel(with row : Int) -> PokemonCellViewModel {
        if isFilter {
            return allPokemonListCellFilter[row]
        }else {
            return allPokemonListCell[row]
        }
    }
}

//MARK: - Private methods to create PokemonCellViewModel
private extension PokedexViewModel {
    func createPokemonViewModel(newResults: [PokemonResults], completion: @escaping ()-> Void) {
        newResults.forEach { pokemonResults in
            let model = PokemonCellViewModel(urlPokemon: pokemonResults.url, pokemon: nil)
            allPokemonListCell.append(model)
        }
        
        completion()
    }
    
}
