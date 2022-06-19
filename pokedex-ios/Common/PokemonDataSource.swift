//
//  RemoteDataSource.swift
//  pokedex-ios
//
//  Created by Davi Aquila on 2022-06-18.
//

import Foundation
import Combine

class PokemonDataSource {
    
    static var shared: PokemonDataSource = PokemonDataSource()
    let decoder = JSONDecoder()
    private init() {}
    
    func fetchAllPokemons() -> Future<PokemonsResponse, AppError> {
        return Future<PokemonsResponse, AppError> { promise in
            WebService.GET(path: WebService.Endpoint.getAllPokemons) { result in
                switch result {
                    case .success(let data):
                        let response = try? self.decoder.decode(PokemonsResponse.self, from: data)
                        guard let response = response else {
                            print("parse error")
                            return
                        }
                        print("retornando")
                        promise(.success(response))
                    case .failure(let networkError, let data):
                        //TODO: tratar erros
                        switch networkError {
                            case .badRequest:
                                print(data ?? "error")
                            case .internalServerError:
                                print(data ?? "error")
                            default:
                                print(data ?? "error")
                        }
                        promise(.failure(AppError.response(message: "error")))
                }
            }
        }
    }
    
    func fetchPokemonDetail(pokemonId: Int) -> Future<PokemonDetail, AppError> {
        return Future<PokemonDetail, AppError> { promise in
            WebService.GET(path: WebService.Endpoint.getPokemonDetail, additional: String(pokemonId)) { result in
                switch result {
                    case .success(let data):
                        let response = try? self.decoder.decode(PokemonDetail.self, from: data)
                        guard let response = response else {
                            print("parse error")
                            return
                        }
                        print("retornando")
                        promise(.success(response))
                    case .failure(let networkError, let data):
                        //TODO: tratar erros
                        switch networkError {
                            case .badRequest:
                                print(data ?? "error")
                            case .internalServerError:
                                print(data ?? "error")
                            default:
                                print(data ?? "error")
                        }
                        promise(.failure(AppError.response(message: "error")))
                }
            }
        }
    }
}
