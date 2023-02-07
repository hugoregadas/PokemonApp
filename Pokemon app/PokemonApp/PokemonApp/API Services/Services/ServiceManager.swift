//
//  ServiceManager.swift
//  PokemonApp
//
//  Created by Hugo Regadas on 10/11/2022.
//

import Foundation


struct ServiceManager : ServiceManagerProtocol {
    //MARK: - Public Methods
    static let shared = ServiceManager()
    
    //MARK: - private Methods
    private var configuration: URLSessionConfiguration
    private var session: URLSession
    private let url = "https://pokeapi.co/api/v2/pokemon"
    
    private init() {
        configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
}


//MARK: - Public Methods
extension ServiceManager {
    func fetchPokemonList(_ pokemonURLString : String, completion: @escaping (Result<[PokemonResults], Error>) -> (Void)) {
        let pokemonUrL: URL
        if !pokemonURLString.isEmpty {
            pokemonUrL = URL(string: pokemonURLString)!
        }else {
            pokemonUrL = URL(string: url)!
        }
        
        let request = URLRequest(url: pokemonUrL)
        
        session.dataTask(with: request) { data, response, error in
            if let error = verifyErrors(data: data, error: error, response: response) {
                completion(.failure(error))
            }
                            
            do {
                let pokedex = try JSONDecoder().decode(PokemonListOutput.self, from: data!)
                print("SUCESS FECTH POKEMON LIST \n \(String(data: data!, encoding: .utf8) ?? "")")
                completion(.success(pokedex.results))
            }catch let error{
                print("Error FECTH POKEMON LIST \n \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchPokemonAllDetails(with pokemonURL: String, completion: @escaping (Result<PokemonDetailsOutput, Error>) -> (Void)) {
        let url = URL(string: pokemonURL)
        
        guard let url = url else { return }
        
        let request  = URLRequest(url: url)
        
        session.dataTask(with: request) { data, response, error in
            if let error = verifyErrors(data: data, error: error, response: response) {
                completion(.failure(error))
            }
                                
            do {
                let details = try JSONDecoder().decode(PokemonDetailsOutput.self, from: data!)
                print("SUCESS FECTH POKEMON LIST \n \(String(data: data!, encoding: .utf8) ?? "")")

                completion(.success(details))
            }catch let error{
                print("Error FECTH POKEMON LIST \n \(error.localizedDescription)")

               completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchPokemonSpeciesDetails(with pokemonURL: String, completion: @escaping (Result<PokemonSpeciesDetailsOutput, Error>) -> (Void)) {
        let url = URL(string: pokemonURL)
        
        guard let url = url else { return }
        
        let request  = URLRequest(url: url)
        
        session.dataTask(with: request) { data, response, error in
            if let error = verifyErrors(data: data, error: error, response: response) {
                completion(.failure(error))
            }
                                
            do {
                let details = try JSONDecoder().decode(PokemonSpeciesDetailsOutput.self, from: data!)
                print("SUCESS FECTH POKEMON LIST \n \(String(data: data!, encoding: .utf8) ?? "")")

                completion(.success(details))
            }catch let error{
                print("Error FECTH POKEMON LIST \n \(error.localizedDescription)")

               completion(.failure(error))
            }
        }.resume()
    }
    
    func getPokemonImageInfoWith(url: String, completion: @escaping (Result <Data, Error>) -> Void){
        var url = URLComponents(string: url)!
        
        let urlRequest = URLRequest(url: url.url!)
        session.downloadTask(with: urlRequest) { localURL, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                let error = NSError(domain: "", code: 999, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                let error = NSError(domain: "", code: response.statusCode, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            guard let localURL = localURL else{
                let error = NSError(domain: "", code: 998, userInfo:nil)
                completion(.failure(error))
                return
            }
            
            do {
                let data = try Data(contentsOf: localURL)
                completion(.success(data))
            }catch let error{
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchPokemonAllDetailsWith(pokemonName: String, completion: @escaping (Result<PokemonDetailsOutput, Error>) -> (Void)) {
        let url = URL(string: (url + "/" + pokemonName))
        
        guard let url = url else { return }
        
        let request  = URLRequest(url: url)
        
        session.dataTask(with: request) { data, response, error in
            if let error = verifyErrors(data: data, error: error, response: response) {
                completion(.failure(error))
            }
                                
            do {
                let details = try JSONDecoder().decode(PokemonDetailsOutput.self, from: data!)
                print("SUCESS FECTH POKEMON LIST \n \(String(data: data!, encoding: .utf8) ?? "")")

                completion(.success(details))
            }catch let error{
                print("Error FECTH POKEMON LIST \n \(error.localizedDescription)")

               completion(.failure(error))
            }
        }.resume()
    }
}


private extension ServiceManager {
    func verifyErrors(data: Data?, error : Error?, response : URLResponse?) -> Error? {
        if let error = error {
            return error
        }
        
        guard let response = response as? HTTPURLResponse else {
            let error = NSError(domain: "", code: 999, userInfo: nil)
            return error
        }
        
        guard (200...299).contains(response.statusCode) else {
            let error = NSError(domain: "", code: response.statusCode, userInfo: nil)
           return error
        }
        
        guard data != nil else {
            let error = NSError(domain: "", code: 998, userInfo:nil)
            return error
        }
        
        return nil
    }
}
