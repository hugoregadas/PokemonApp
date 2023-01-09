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
    private let url = "https://pokeapi.co/api/v2/pokedex/"
    
    private init() {
        configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
}


//MARK: - Public Methods
extension ServiceManager {
    func fetchPokedex(completion: @escaping (Result<[PokedexOutputList], Error>) -> (Void)) {
        let urlPokedex = URL(string: url)
        
        guard let urlPokedex = urlPokedex else {
            return
        }
        
        let request = URLRequest(url: urlPokedex)
        
        session.dataTask(with: request) { data, response, error in
            if let error = verifyErrors(data: data, error: error, response: response) {
                completion(.failure(error))
            }
                            
            do {
                let pokedex = try JSONDecoder().decode(PokedexOutput.self, from: data!)
                completion(.success(pokedex.results))
            }catch let error{
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchPokedexInfo(with pokedexStringURL: String, completion: @escaping (Result<PokedexObjectOutput, Error>) -> (Void)) {
        let url = URL(string: pokedexStringURL)
        
        guard let url = url else { return }
        
        let request  = URLRequest(url: url)
        
        session.dataTask(with: request) { data, response, error in
            if let error = verifyErrors(data: data, error: error, response: response) {
                completion(.failure(error))
            }
            
            
            //let x = String(data: data!, encoding: .utf8)
            //NSLog(x!)
                    
            do {
                let pokedex = try JSONDecoder().decode(PokedexObjectOutput.self, from: data!)
                completion(.success(pokedex))
            }catch let error{
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
