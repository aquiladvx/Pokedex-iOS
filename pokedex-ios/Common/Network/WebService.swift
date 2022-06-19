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
    
    enum HTTPStatusCode: Int {
        case info = 100
        case success = 200
        case redirect = 300
        case client = 400
        case server = 500
        case unknown = 999
        
        init(code: Int) {
            switch code {
                case 100...199: self = .info
                case 200...299: self = .success
                case 300...399: self = .redirect
                case 400...499: self = .client
                case 500...599: self = .server
                default: self = .unknown
            }
        }
    }
    
    enum RemoteResult {
        case success(Data)
        case failure(NetworkError, Data?)
    }
    
    enum Endpoint: String {
        
        case base = "https://pokeapi.co/api/v2"
        
        case getAllPokemons = "/pokemon?limit=151"
        case getPokemonDetail = "/pokemon/"
    }
    
    private static func completeUrl(path: Endpoint, aditional: String? = nil) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path.rawValue)\(aditional ?? "")") else {return nil}
        return URLRequest(url: url)
    }
    
    static func call(request: URLRequest, body: Encodable? = nil, completion: @escaping (RemoteResult) -> Void) {
        print("CALL: \(request.url)")
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                //TODO: tratar erro de chamadas
                completion(.failure(.internalServerError, nil))
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                let statusCode = HTTPStatusCode(code: httpResponse.statusCode)
                
                switch statusCode {
                    case .success, .redirect:
                        completion(.success(data))
                    case .client:
                        completion(.failure(.badRequest, nil))
                    case .server:
                        completion(.failure(.internalServerError, nil))
                    default:
                        completion(.failure(.undefined, nil))
                }
            }
        }.resume()
    }
    
    
    static func GET(path: Endpoint, additional: String? = nil, completion: @escaping (RemoteResult) -> Void) {
        guard var urlRequest = completeUrl(path: path, aditional: additional) else { return }
        
        urlRequest.httpMethod = "GET"
        call(request: urlRequest, completion: completion)
        
    }
}
