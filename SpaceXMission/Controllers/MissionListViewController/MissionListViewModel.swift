//
//  MissionListViewModel.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation
// TODO: - Renamed After process is done
final class MissionListViewModel {
    
    var remainedMissionInCurrentPage: [Mission] = []
    var displayMissions: [Mission] = [] {
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
    
    init(repository: MissionRepositoryProtocol = MissionRepository(),
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
            remainedMissionInCurrentPage.appendIfNotDuplicated(contentsOf: newMissions)
            await loadData()
        } catch {
            showError("error_fetching_new_missions" .localized())
        }
    }
    
}

// MARK: - Action Functions
extension MissionListViewModel {
    
    func loadData() async {
        if remainedMissionInCurrentPage.count == 0 {
            await fetchNewMissions()
        } else {
            var newLoad: [Mission] = []
            for i in 0...19 {
                if i < remainedMissionInCurrentPage.count {
                    newLoad.append(remainedMissionInCurrentPage[i])
                    remainedMissionInCurrentPage.remove(at: i)
                } else {
                    break
                }
            }
            if newLoad.count != 0 {
                displayMissions.appendIfNotDuplicated(contentsOf: newLoad)
            }
        }
        
    }
}

