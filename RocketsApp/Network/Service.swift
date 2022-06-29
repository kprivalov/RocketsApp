//
//  Service.swift
//  RocketsApp
//
//  Created by Kirill Privalov on 21.06.2022.
//

import Foundation
import os

final class Network {
    static let shared = Network()
    private static let decoder = JSONDecoder()
    private static let encoder = JSONEncoder()
    private static let logger = Logger()

    init() {
        Network.decoder.keyDecodingStrategy = .convertFromSnakeCase
        Network.encoder.keyEncodingStrategy = .convertToSnakeCase
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
            let json = try? Network.decoder.decode(model.self, from: data)
            guard let json = json else { return }
            completion(json)
        case .failure(let error):
            Network.logger.info(#"An error occured: \#(error.localizedDescription)"#)
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
