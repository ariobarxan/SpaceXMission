//
//  RequestHeaderManager.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation

final class RequestHeaderManager {
    
    static let shared = RequestHeaderManager()
    
    enum HTTPDefaultHeaderField: String {
        case contentType = "Content-Type"
    }

    enum HTTPDefaultHeaderValue: String {
        case json = "application/json"
    }

    func getHeader(for request: RequestManager) -> [(value: String, field: String)] {
        let contentTypeValue = HTTPDefaultHeaderValue.json.rawValue
        let contentTypeField = HTTPDefaultHeaderField.contentType.rawValue
        let defaultHeaders = [(value: contentTypeValue, field:contentTypeField)]
        
        switch request {
        case .latestMission, .launchesWithQuery, .image:
            return  defaultHeaders
        }
    }

}

