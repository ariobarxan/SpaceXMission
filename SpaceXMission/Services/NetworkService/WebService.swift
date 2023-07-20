//
//  WebService.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation

enum NetworkError: Error {
    case urlStringISInvalid
    case invalidResponse
    case badUrl
    case decodingError
}

class WebService {
    
    static let shared = WebService()
    
    func fetchLaunchWithQuery(query: LaunchAPIQuery) async throws -> MissionDoc {
        return try await baseRequest(forRequest: .launchesWithQuery(query: query), type: MissionDoc.self)
    }
    
    func fetchLatestMission() async throws -> Mission {
        return try await baseRequest(forRequest: .latestMission, type: Mission.self)
    }
   
    func baseRequest<T: Codable>(forRequest requestManager: RequestManager, type: T.Type) async throws -> T {
        guard let request = try? requestManager.asURLRequest() else {
            throw NetworkError.urlStringISInvalid
        }
        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw NetworkError.badUrl
        }
        guard let httpResponse = response as? HTTPURLResponse,
            httpResponse.statusCode == 200
        else {
            throw NetworkError.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: data)
            Log.d("\(result as Any)")
            return result
        } catch DecodingError.dataCorrupted(let context) {
            Log.d("\(context)")
            throw NetworkError.decodingError
        } catch DecodingError.keyNotFound(let key, let context) {
            Log.d("Key '\(key)' not found: \(context.debugDescription)")
            Log.d("codingPath: \(context.codingPath)")
            throw NetworkError.decodingError

        } catch DecodingError.valueNotFound(let value, let context) {
            Log.d("Value '\(value)' not found: \(context.debugDescription)")
            Log.d("codingPath: \(context.codingPath)")
            throw NetworkError.decodingError

        } catch DecodingError.typeMismatch(let type, let context) {
            Log.d("Type '\(type)' mismatch: \(context.debugDescription)")
            Log.d("codingPath: \(context.codingPath)")
            throw NetworkError.decodingError
        } catch {
            Log.d("error: \(error)")
            throw NetworkError.decodingError
        }
        
    }
    
}
