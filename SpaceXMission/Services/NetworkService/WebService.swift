//
//  WebService.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation

final class WebService {
    
    static let shared = WebService()
    
    func fetchLaunchWithQuery(query: LaunchAPIQuery) async throws -> MissionDoc {
        return try await baseRequest(forRequest: .launchesWithQuery(query: query), type: MissionDoc.self)
    }
    
    func fetchLatestMission() async throws -> Mission {
        return try await baseRequest(forRequest: .latestMission, type: Mission.self)
    }
    
    func fetchImageData(withURLString urlString: String) async throws -> Data {
        return try await baseRequestGetData(.image(url: urlString))
    }
   
    private func baseRequest<T: Codable>(forRequest requestManager: RequestManager, type: T.Type) async throws -> T {
        let data = try await baseRequestGetData(requestManager)
        return try baseRequestDecodeData(data, for: type)
    }
    
    private func baseRequestGetData(_ requestManager :RequestManager ) async throws -> Data {
        // TODO: - Enahnce logs
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
        return data
    }
    
    private func baseRequestDecodeData<T: Codable>(_ data: Data, for type: T.Type) throws -> T {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: data)
            //Log.d("\(result as Any)")
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
