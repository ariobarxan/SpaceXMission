//
//  MissionDetailsViewModel.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/21/23.
//

import Foundation

final class MissionDetailsViewModel {
    
    var mission: Mission
    var reloadTableView: VoidClosure
    var detailsData: [(title: String, description: String, isVerticallyFormatted: Bool)] = []
    var missionImageUrlString: String!
    
    init(mission: Mission, reloadTableView: @escaping VoidClosure) {
        self.mission = mission
        self.reloadTableView = reloadTableView
        fillMissionImageUrlString()
        fillDetailsData()
    }
}

// MARK: - Action Functions
extension MissionDetailsViewModel {
    
    func fillDetailsData() {
        if let missionName = mission.name {
            let missionNameTitle =  "Mission Name"
            let missionNameTuple = (missionNameTitle, missionName, false)
            detailsData.append(missionNameTuple)
        }

        let detailsTitle = "Details of the mission"
        let details = mission.details ?? "Unfortunately there are no details about this mission!"
        let detailsTuple = (detailsTitle, details, true)
        detailsData.append(detailsTuple)
        
        let missionDateTitle = "Execution Date"
        let missionDate = mission.dateLocal ?? "No information about data"
        let missionDateTuple = (missionDateTitle, missionDate, false)
        detailsData.append(missionDateTuple)
        
        if let wikipediaLink = mission.links?.wikipedia {
            let wikipediaLinkTitle = "Wikipedia Link"
            let wikipediaLinkTuple = (wikipediaLinkTitle, wikipediaLink,true)
            detailsData.append(wikipediaLinkTuple)
        }
        
        reloadTableView()
    }
    
    func fillMissionImageUrlString() {
        if let urlString = mission.links?.flickr?.original?.first {
            missionImageUrlString = urlString
        } else {
            missionImageUrlString = mission.links?.patch?.large ?? ""
        }
    }
}
