//
//  MissionRepository.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation

protocol MissionRepositoryProtocol {
    func fetchNewMissions(forPage page: Int, withLimit limit: Int) async throws -> [Mission]
}

enum DataError: Error {
    case noData
}

final class MissionRepository: MissionRepositoryProtocol {
        
    private var missionDoc: MissionDoc!
    
    func fetchNewMissions(forPage page: Int, withLimit limit: Int) async throws -> [Mission]{
        let apiQuery = APIQuery()
        let sort = Sort()
        let options = Options(limit: limit, page: page, sort: sort)
        let query = LaunchAPIQuery(query: apiQuery, options: options)
        let missionDoc = try await WebService.shared.fetchLaunchWithQuery(query: query)
        guard let missions = missionDoc.docs else {
            throw DataError.noData
        }
        return missions
    }
}
