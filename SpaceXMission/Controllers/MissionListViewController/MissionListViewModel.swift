//
//  MissionListViewModel.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation

final class MissionListViewModel {
    
    var missions: [Mission] = [] {
        didSet {
            reloadTableView()
        }
    }
    
    var repository: MissionRepositoryProtocol
    var reloadTableView: VoidClosure
    var showError: (_ message: String) -> ()
    var handleShowLoading: (Bool) -> ()
    
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
    
    init(repository: MissionRepositoryProtocol,
         reloadTableView: @escaping VoidClosure,
         showError: @escaping (_ message: String) -> Void,
         handleShowLoading: @escaping (Bool) -> Void
    ) {
        self.repository = repository
        self.reloadTableView = reloadTableView
        self.showError = showError
        self.handleShowLoading = handleShowLoading
        
        Task{
            await fetchNewMissions()
        }
    }
}

//MARK: - Fetching Data
extension MissionListViewModel {
    
    func fetchNewMissions() async {
        page += 1
        do {
            let newMissions = try await repository.fetchNewMissions(forPage: page, withLimit: limit)
            missions.appendIfNotDuplicated(contentsOf: newMissions)
        } catch {
            showError("error_fetching_new_missions" .localized())
        }
    }
    
}
