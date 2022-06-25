//
//  Service.swift
//  RocketsApp
//
//  Created by Kirill Privalov on 21.06.2022.
//

import Foundation

final class Network {
    static let shared = Network()
    lazy var decoder = JSONDecoder()
    lazy var encoder = JSONEncoder()

    init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        encoder.keyEncodingStrategy = .convertToSnakeCase
    }

    private func sendRequest(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                completion(.success(data))
            }
        }
        task.resume()
    }
    
    private func parseResponse<T: Decodable>(result: Result<Data, Error>, model: T.Type, completion: @escaping (T) -> Void) {
        switch result {
        case .success(let data):
            let JSON = try? decoder.decode(model.self, from: data)
            guard let JSON = JSON else { return }
            completion(JSON)
        case .failure(let error):
            print(error)
            return
        }
    }
        
    func fetchRockets(completion: @escaping (Rockets) -> Void) {
        sendRequest(url: URL.rocketsEndpoint) { result in
            self.parseResponse(result: result, model: Rockets.self) { response in
                completion(response)
            }
        }
    }
    
    func fetchLaunches(completion: @escaping (Launches) -> Void) {
        sendRequest(url: URL.launchesEndpoint) { result in
            self.parseResponse(result: result, model: Launches.self) { response in
                completion(response)
            }
        }
    }
}
