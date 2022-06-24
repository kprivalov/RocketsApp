//
//  Constants.swift
//  RocketsApp
//
//  Created by Kirill Privalov on 21.06.2022.
//

public struct Constants {
    static let baseEndpoint = "https://api.spacexdata.com/v4/"
    
    enum Path: String {
        case launches
        case rockets
    }
}
