//
//  Service.swift
//  RocketsApp
//
//  Created by Kirill Privalov on 21.06.2022.
//

import Foundation

final class Network {
    static let shared = Network()
    let decoder: JSONDecoder
    let encoder: JSONEncoder

    init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
    }

    func sendRequest(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
        task.suspend()
    }
        
    func fetchRockets(_ endpoint: URL = URL.rocketsEndpoint, completion: @escaping (Rockets) -> Void) {
        sendRequest(url: URL.rocketsEndpoint) { [decoder] (result) in
            switch result {
            case .success(let data):
                if let rockets = try? decoder.decode(Rockets.self, from: data) {
                    completion(rockets)
                }
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
    func fetchLaunches(_ endpoint: URL = URL.launchesEndpoint, completion: @escaping ((Launches)?) -> Void) {
        sendRequest(url: URL.launchesEndpoint) { [decoder] (result) in
            switch result {
            case .success(let data):
                if let launches = try? decoder.decode(Launches.self, from: data) {
                    completion(launches)
                }
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
}
