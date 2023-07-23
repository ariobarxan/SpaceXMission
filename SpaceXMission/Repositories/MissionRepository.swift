//
//  MissionRepository.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation
import CoreData

protocol MissionRepositoryProtocol {
    func fetchNewMissions(forPage page: Int, withLimit limit: Int) async throws -> [Mission]
    func isMissionBookMarked(withID id: String) throws -> Bool
    func bookMarkMission(withID id: String, isBookMarked: Bool) throws
}

final class MissionRepository: MissionRepositoryProtocol {
  
    private var missionDoc: MissionDoc!
    private var coreDataContext = CoreDataService.shared.persistentContainer.viewContext
    
    func fetchNewMissions(forPage page: Int, withLimit limit: Int) async throws -> [Mission]{
        let apiQuery = APIQuery()
        let sort = Sort()
        let options = Options(limit: limit, page: page, sort: sort)
        let query = LaunchAPIQuery(query: apiQuery, options: options)
        let missionDoc = try await WebService.shared.fetchLaunchWithQuery(query: query)
        guard let missions = missionDoc.docs else {
            throw RepositoryError.noData
        }
        return missions
    }
    
    func isMissionBookMarked(withID id: String) throws -> Bool {
        let predicate = NSPredicate(format: "id == %@", id)
        let request = SpaceXMission.fetchRequest() as NSFetchRequest<SpaceXMission>
        request.predicate = predicate
        
        let isBookMarked = try !coreDataContext.fetch(request).isEmpty
        
        return isBookMarked
    }
    
    func bookMarkMission(withID id: String, isBookMarked: Bool) throws {
        let predicate = NSPredicate(format: "id == %@", id)
        let request = SpaceXMission.fetchRequest() as NSFetchRequest<SpaceXMission>
        request.predicate = predicate
        
        if let mission = try coreDataContext.fetch(request).first {
            coreDataContext.delete(mission)
        } else {
            let mission = SpaceXMission(context: coreDataContext)
            mission.id = id
        }
        try coreDataContext.save()
    }
    
}
