//
//  PokemonCellViewModel.swift
//  PokemonApp
//
//  Created by Hugo Regadas on 09/01/2023.
//

import Foundation
import UIKit

protocol PokemonCellViewModelDelegate : NSObject{
    func updateCollectionView()
}


class PokemonCellViewModel {
    private var pokemon : PokemonDetailsOutput?
    private var serviceAPI: ServiceManager = ServiceManager.shared
    private var imageData : Data?
    private var backGroundColorName : String?

    //MARK: - Public methods
    var updatedData = false
    weak var delegate : PokemonCellViewModelDelegate?

    init(urlPokemon: String , isFilter: Bool = false, pokemon: PokemonDetailsOutput?) {
        if isFilter {
            self.pokemon = pokemon
            self.fetchBackgroundColor(url: pokemon!.species.url)
            self.fetchImagesWith(url: pokemon!.sprites.front_default)
        }else {
            pokemonDetails(with: urlPokemon)
        }
    }
}


extension PokemonCellViewModel{
    func getPokemonName() -> String {
        if let name  = pokemon?.name {
            return name
        }
        return "Name Error"
    }
    
    func getPokemonNumber() -> String {
        if let number = pokemon?.order {
            return "\(number)"
        }
        
        return "Error"
    }
    
    func getPokemonImage() -> UIImage {
        if let imageData = imageData {
            return UIImage(data: imageData)!
        }
        
        return  UIImage(named: "001")!
    }
    
    func getBackgroundColor() -> UIColor {
        return Utils().pokemonColor(color: getBackgroundColorText())
    }
}

private extension PokemonCellViewModel {
    func pokemonDetails(with url  : String) {
        serviceAPI.fetchPokemonAllDetails(with: url) { result in
            switch result {
            case .failure(_):
                break
            case .success(let pokemonDetails):
                self.pokemon = pokemonDetails
                self.fetchBackgroundColor(url: pokemonDetails.species.url)
                self.fetchImagesWith(url: pokemonDetails.sprites.front_default)
                break
            }
        }
    }
    
    func fetchImagesWith(url : String) {
        serviceAPI.getPokemonImageInfoWith(url: url) { result in
            switch result {
            case .success(let success):
                self.imageData = success
                self.delegate?.updateCollectionView()
            case .failure(_):
                break
            }
        }
    }
    
    func fetchBackgroundColor(url: String) {
        serviceAPI.fetchPokemonSpeciesDetails(with: url) { result in
            switch result {
            case .success(let success):
                self.updatedData = true
                self.backGroundColorName = success.color.name
                self.delegate?.updateCollectionView()
            case .failure(_):
                break
            }
        }
    }
    
    func getBackgroundColorText() -> String {
        return backGroundColorName ?? ""
    }
}
