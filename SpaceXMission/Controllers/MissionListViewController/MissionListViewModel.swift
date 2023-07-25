//
//  MissionListViewModel.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import Foundation
// TODO: - Renamed After process is done
final class MissionListViewModel {
    
    var isLoading = false
    var tableViewMissions: [Mission] = []
    private var availableMissions: [Mission] = []
    private var repository: MissionRepositoryProtocol
    private var reloadTableView: VoidClosure
    private var showError: (_ message: String) -> ()
    private var handleShowLoading: (Bool) -> ()
    private var hasNextPage = true
    private var page: Int = 1
    private var limit: Int = 50
    private var lastAddedMissionIndex = 0
    private var numberOfMissionsInTableViewPage = 19
    private var thereAreMissions = true
    private var shouldAllowReloadingTableView = true
    
    init(repository: MissionRepositoryProtocol = MissionRepository(),
         reloadTableView: @escaping VoidClosure,
         showError: @escaping (_ message: String) -> Void,
         handleShowLoading: @escaping (_ isLoading: Bool) -> Void) {
        self.repository = repository
        self.reloadTableView = reloadTableView
        self.showError = showError
        self.handleShowLoading = handleShowLoading
    }
}

//MARK: - Fetching Data
extension MissionListViewModel {
    
    private func fetchNewMissions() async ->  [Mission]? {
        if hasNextPage {
            do {
                let data = try await repository.fetchNewMissions(forPage: page, withLimit: limit)
                if let missions = data.missions {
                    page += 1
                    hasNextPage = data.hasNextPage
                    return missions
                }
            } catch {
                showError("error_fetching_new_missions" .localized())
            }
        }
        return nil
    }
}

// MARK: - Action Functions
extension MissionListViewModel {
    
    func loadData() async {
        guard !isLoading else {return}
        isLoading = true
        if thereAreNotAvailableMissions() {
            let missions = await fetchNewMissions()
            if let missions = missions {
                availableMissions.appendIfNotDuplicated(contentsOf: missions)
            }
        }
        
        for index in lastAddedMissionIndex...(lastAddedMissionIndex + numberOfMissionsInTableViewPage) {
            if index < availableMissions.count {
                tableViewMissions.appendIfNotDuplicated( availableMissions[index])
            } else {
                break
            }
        }
        lastAddedMissionIndex = tableViewMissions.count - 1
        if shouldAllowReloadingTableView {
            reloadTableView()
        }
        
        if thereAreNoMoreMissions() {
            shouldAllowReloadingTableView = false
        }
        isLoading = false
    }
    
    private func thereAreNotAvailableMissions() -> Bool {
        return tableViewMissions.count == availableMissions.count && hasNextPage
    }
    
    private func thereAreNoMoreMissions() -> Bool {
        return tableViewMissions.count == availableMissions.count && !hasNextPage
    }
}

