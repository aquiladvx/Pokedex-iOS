//
//  RemoteDataSource.swift
//  pokedex-ios
//
//  Created by Davi Aquila on 2022-06-18.
//

import Foundation
import Combine

class RemoteDataSource {
    
    static var shared: RemoteDataSource = RemoteDataSource()
    private init() {}
    
    func fetchAllPokemons() -> Future<PokemonsResponse, AppError> {
        return Future<PokemonsResponse, AppError> { promise in
            WebService.GET(path: WebService.Endpoint.getAllPokemons) { result in
                let decoder = JSONDecoder()
                
                switch result {
                    case .success(let data):
                        let response = try? decoder.decode(PokemonsResponse.self, from: data)
                        guard let response = response else {
                            print("parse error")
                            return
                        }
                        print("retornando")
                        promise(.success(response))
                    case .failure(let networkError, let data):
                        print("error")
                        promise(.failure(AppError.response(message: "error")))
                }
            }
        }
    }
}
