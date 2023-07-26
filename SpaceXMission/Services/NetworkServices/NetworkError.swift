//
//  NetworkErrors.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/21/23.
//

import Foundation

enum NetworkError: Error {
    case urlStringISInvalid
    case invalidResponse
    case badUrl
    case decodingError
    case noConnection
}
