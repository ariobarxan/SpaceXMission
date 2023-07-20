//
//  RequestBodyManager.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation

final class RequestBodyManager {
    
    static let shared = RequestBodyManager()
    
    func getBody(for request: RequestManager) -> [String: Any]? {
        switch request {
        case .latestMission:
            return nil
        case .launchesWithQuery(let query):
            let temp: [String : Any] = [
                "query": query.dict
            ]
            return temp
        }
    }
}
