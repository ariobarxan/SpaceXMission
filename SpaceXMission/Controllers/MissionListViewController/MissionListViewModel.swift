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
    var displayMissions: [Mission] = []
    var repository: MissionRepositoryProtocol
    var reloadTableView: VoidClosure
    var showError: (_ message: String) -> ()
    var handleShowLoading: (Bool) -> ()
    var isLoading = false
    private var hasNextPage = true
    private var page: Int = 1
    private var limit: Int = 50
    private var lastAddedPage = 0
    private var thereAreMissions = true
    private var shouldAllowReloadingTableView = true
    
    init(repository: MissionRepositoryProtocol = MissionRepository(),
         reloadTableView: @escaping VoidClosure,
         showError: @escaping (_ message: String) -> Void,
         handleShowLoading: @escaping (Bool) -> Void
    ) {
        self.repository = repository
        self.reloadTableView = reloadTableView
        self.showError = showError
        self.handleShowLoading = handleShowLoading
    }
}

//MARK: - Fetching Data
extension MissionListViewModel {
    
    func fetchNewMissions() async ->  [Mission]? {
        if hasNextPage {
            do {
                let data = try await repository.fetchNewMissions(forPage: page, withLimit: limit)
                print("for page \(page)")
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
        if displayMissions.count == remainedMissionInCurrentPage.count && hasNextPage {
            let missions = await fetchNewMissions()
            if let missions = missions {
                remainedMissionInCurrentPage.appendIfNotDuplicated(contentsOf: missions)
            }
        }
        
        for i in lastAddedPage...(lastAddedPage + 19) {
            if i < remainedMissionInCurrentPage.count {
                displayMissions.appendIfNotDuplicated( remainedMissionInCurrentPage[i])
            } else {
                break
            }
        }
        lastAddedPage = displayMissions.count - 1
        if shouldAllowReloadingTableView {
            reloadTableView()
        }
        
        if displayMissions.count == remainedMissionInCurrentPage.count && !hasNextPage {
            shouldAllowReloadingTableView = false
        }
        isLoading = false
    }
}

