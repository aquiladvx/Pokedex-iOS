//
//  WebService.swift
//  pokedex-ios
//
//  Created by Davi Aquila on 2022-06-18.
//

import Foundation

enum WebService {
    
    enum NetworkError {
        case undefined
        case badRequest
        case notFound
        case unauthorized
        case internalServerError
    }
    
    enum RemoteResult {
        case success(Data)
        case failure(NetworkError, Data?)
    }
    
    enum Endpoint: String {
        case base = "https://pokeapi.co/api/v2"
        
        case getAllPokemons = "/pokemon?limit=151"
    }
    
    private static func completeUrl(path: Endpoint) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path.rawValue)") else {return nil}
        return URLRequest(url: url)
    }
    
    static func call(request: URLRequest, body: Encodable? = nil, completion: @escaping (RemoteResult) -> Void) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                //TODO: tratar erro de chamadas
                completion(.failure(.internalServerError, nil))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 200, 304:
                    completion(.success(data))
                case 400:
                    completion(.failure(.badRequest, nil))
                case 500:
                    completion(.failure(.internalServerError, nil))
                default:
                    completion(.failure(.undefined, nil))
                }
            }

        }.resume()
    }
    

    static func GET(path: Endpoint, completion: @escaping (RemoteResult) -> Void) {
        guard var urlRequest = completeUrl(path: path) else { return }
        
        urlRequest.httpMethod = "GET"
        call(request: urlRequest, completion: completion)
    
    }
}
