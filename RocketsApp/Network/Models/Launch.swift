//
//  Launch.swift
//  RocketsApp
//
//  Created by Kirill Privalov on 22.06.2022.
//
import Foundation

// MARK: - LaunchElement
struct Launch: Decodable {
    let fairings: Fairings?
    let links: Links
    let staticFireDateUTC: String?
    let staticFireDateUnix: Int?
    let net: Bool
    let window: Int?
    let rocket: Rocket
    let success: Bool?
    let failures: [Failure]
    let details: String?
    let crew, ships, capsules, payloads: [String]
    let launchpad: String
    let flightNumber: Int
    let name, dateUTC: String
    let dateUnix: Int
    let dateLocal: Date
    let datePrecision: String
    let upcoming: Bool
    let cores: [Core]
    let autoUpdate, tbd: Bool
    let launchLibraryID: String?
    let id: String
}

extension Launch {
    // MARK: - Core
    struct Core: Decodable {
        let core: String?
        let flight: Int?
        let gridfins, legs, reused, landingAttempt: Bool?
        let landingSuccess: Bool?
        let landingType: String?
        let landpad: String?
    }

    // MARK: - Failure
    struct Failure: Decodable {
        let time: Int
        let altitude: Int?
        let reason: String
    }

    // MARK: - Fairings
    struct Fairings: Decodable {
        let reused, recoveryAttempt, recovered: Bool?
        let ships: [String]
    }

    // MARK: - Links
    struct Links: Decodable {
        let patch: Patch
        let reddit: Reddit
        let flickr: Flickr
        let presskit: String?
        let webcast: String?
        let youtubeID: String?
        let article: String?
        let wikipedia: String?
    }

    // MARK: - Flickr
    struct Flickr: Decodable {
        let small: [String]
        let original: [String]
    }

    // MARK: - Patch
    struct Patch: Decodable {
        let small, large: String?
    }

    // MARK: - Reddit
    struct Reddit: Decodable {
        let campaign: String?
        let launch: String?
        let media, recovery: String?
    }
}

typealias Launches = [Launch]
