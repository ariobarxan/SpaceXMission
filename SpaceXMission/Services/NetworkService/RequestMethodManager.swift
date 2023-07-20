//
//  RequestMethodManager.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation

enum RequestMethodManager: String {
    case post = "POST"
    case get = "GET"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

extension RequestMethodManager {
    
    static func getHTTPMethod(for request: RequestManager) -> String {
        switch request {
        case .latestMission:
            return RequestMethodManager.get.rawValue
        case .launchesWithQuery:
            return RequestMethodManager.post.rawValue
            
        }
    }
}
