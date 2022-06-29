//
//  URL+Endpoints.swift
//  RocketsApp
//
//  Created by Kirill Privalov on 22.06.2022.
//

import Foundation

extension URL {
    static var rocketsEndpoint: URL {
        URL(string: Constants.baseEndpoint + Constants.Path.rockets.rawValue)!
    }

    static var launchesEndpoint: URL {
        URL(string: Constants.baseEndpoint + Constants.Path.launches.rawValue)!
    }
}
