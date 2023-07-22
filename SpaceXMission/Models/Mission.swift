//
//  Mission.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation

struct MissionDoc: Codable, Equatable {
    let docs: [Mission]?
    let totalDocs, limit, totalPages, page: Int?
    let pagingCounter: Int?
    let hasPrevPage, hasNextPage: Bool?
    let nextPage: Int?
}

// MARK: - Mission
struct Mission: Codable, Equatable {
    let links: Links?
    let net: Bool?
    let rocket: String?
    let success: Bool?
    let details: String?
    let capsules, payloads: [String]?
    let launchpad: String?
    let flightNumber: Int?
    let name, dateUTC: String?
    let dateUnix: Int?
    let dateLocal: String?
    let datePrecision: String?
    let upcoming: Bool?
    let autoUpdate, tbd: Bool?
    let launchLibraryID, id: String?

    enum CodingKeys: String, CodingKey {
        case links
        case net, rocket, success, capsules, payloads, launchpad, details
        case flightNumber = "flight_number"
        case name
        case dateUTC = "date_utc"
        case dateUnix = "date_unix"
        case dateLocal = "date_local"
        case datePrecision = "date_precision"
        case upcoming
        case autoUpdate = "auto_update"
        case tbd
        case launchLibraryID = "launch_library_id"
        case id
    }
}

// MARK: - Links
struct Links: Codable, Equatable {
    
    let patch: Patch?
    let reddit: Reddit?
    let flickr: Flickr?
    let webcast: String?
    let youtubeID: String?
    let wikipedia: String?

    enum CodingKeys: String, CodingKey {
        case patch, reddit, flickr, webcast
        case youtubeID = "youtube_id"
        case wikipedia
    }
}

// MARK: - Patch
struct Patch: Codable, Equatable {
    let small, large: String?
}

// MARK: - Reddit
struct Reddit: Codable, Equatable {
    let launch: String?
}

struct Flickr: Codable, Equatable {
    let small: [String]?
    let original: [String]?
}
