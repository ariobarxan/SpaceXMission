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
    var shouldShowError: (_ message: String) -> ()
    var shouldShowLoading: (Bool) -> ()
    
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
        page += 1
        do {
            missions = try await repository.fetchNewMissions(forPage: page, withLimit: limit)
        } catch {
            shouldShowError("error_fetching_new_missions" .localized())
        }
    }
    
}
