//
//  MissionListViewModel.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation

final class MissionListViewModel {
    
    var missions: [Mission] = []
    
    var repository: MissionRepositoryProtocol
    var reloadTableView: VoidClosure
    var shouldShowError: (_ message: String) -> ()
    var shouldShowLoading: (Bool) -> ()
    
    init(repository: MissionRepositoryProtocol,
         reloadTableView: @escaping VoidClosure,
         shouldShowError: @escaping (_ message: String) -> Void,
         shouldShowLoading: @escaping (Bool) -> Void
    ) {
        self.repository = repository
        self.reloadTableView = reloadTableView
        self.shouldShowError = shouldShowError
        self.shouldShowLoading = shouldShowLoading
    }
}

//MARK: - Fetching Data
extension MissionListViewModel {
    
    func fetchNewMissions() async {
        do {
            let newMissions = try await repository.fetchNewMissions()
        } catch {
            shouldShowError("")
        }
    }
    
}
