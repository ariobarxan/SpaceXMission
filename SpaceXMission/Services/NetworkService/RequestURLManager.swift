//
//  RequestURLManager.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation

final class RequestURLManager {
    
    static let shared = RequestURLManager()
    
    var baseURL: String {
        get {
            return "https://api.spacexdata.com/v5/launches/"
        }
    }
    
    func getURL(for request : RequestManager) -> URL? {
        switch request {
        case .latestMission:
            return URL(string: "https://api.spacexdata.com/v5/launches/latest")
        case .launchesWithQuery:
            return URL(string: baseURL + "query")
        }
    }
}
