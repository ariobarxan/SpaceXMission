//
//  MissionRepository.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation

protocol MissionRepositoryProtocol {
    func fetchNewMissions() async throws -> [Mission]
}

enum DataError: Error {
    case noData
}

final class MissionRepository: MissionRepositoryProtocol {
        
    private var missionDoc: MissionDoc!
    private var page: Int = 0 {
        didSet {
            if page == 1 {
                limit = 50
            } else {
                limit = 20
            }
        }
    }
    private var limit: Int = 0
    
    private var isInitialMissionWithQueryRequest: Bool {
        get {
            return page == 0 ? true : false
        }
    }
    
    func fetchNewMissions() async throws -> [Mission]{
        let sort = Sort()
        let options = Options(limit: 5, page: 1, sort: sort)
        let query = LaunchAPIQuery(options: options)
        let missionDoc = try await WebService.shared.fetchLaunchWithQuery(query: query)
        guard let missions = missionDoc.docs else {
            throw DataError.noData
        }
        return missions
    }
}
