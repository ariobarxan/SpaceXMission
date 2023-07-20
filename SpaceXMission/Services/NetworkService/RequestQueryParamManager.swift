//
//  RequestQueryParamManager.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation

final class RequestQueryParamManager {
    
    static let shared = RequestQueryParamManager()

    
    func getQueryParam(for request: RequestManager) -> [String: String]? {
        switch request {
        case .latestMission, .launchesWithQuery:
            return nil
        }
    }
}
