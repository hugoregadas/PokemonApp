//
//  PokedexViewModel.swift
//  PokemonApp
//
//  Created by Hugo Regadas on 10/11/2022.
//

import Foundation

class PokedexListViewModel {
    //MARK: - Public Properties
    var numberOfPokedex = 0
    let pokedexTitle = "Pokémon\r All - Pokedex"
    
    //MARK: Private properties
    private var pokedexObject : PokedexOutputList?
    private var serviceAPi: ServiceManager
    private var list: [PokedexOutputList] = [] {
        willSet {
            numberOfPokedex = newValue.count
        }
    }
    
    init(serviceAPi: ServiceManager) {
        self.serviceAPi = serviceAPi
    }
}

//MARK: - private methods
private extension PokedexListViewModel {
    func saveList(With list: [PokedexOutputList]) {
        self.list = list
    }
}

//MARK: - Public Methods
extension PokedexListViewModel {
    func fetchAllPokedex(completion :@escaping (Bool, Error?)->(Void)){
        serviceAPi.fetchPokedex { result in
            switch result {
            case .success(let pokedexList):
                self.saveList(With: pokedexList)
                completion(true, nil)
                break
            case .failure(let error) :
                completion(false, error)
                break
            }
        }
    }
    
    func fetchPokedexName(with row: Int) -> String{
        return "\(row + 1) : " + list[row].name
    }
    
    func selectPokedex(in row: Int){
        pokedexObject = list[row]
    }
}

//MARK: - Configure PokedexViewModel
extension PokedexListViewModel{
    func initializePokedexViewModel() -> PokedexViewModel{
        return PokedexViewModel(serviceAPI: self.serviceAPi, pokedexSelected: pokedexObject!)
    }
    
}
