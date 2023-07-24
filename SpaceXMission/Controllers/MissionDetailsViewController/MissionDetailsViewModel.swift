//
//  MissionDetailsViewModel.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/21/23.
//

import Foundation

final class MissionDetailsViewModel {
    
    var missionRepository: MissionRepositoryProtocol
    var mission: Mission
    var reloadTableView: VoidClosure
    var detailsData: [(key: String, value: String, isVerticallyFormatted: Bool, valueContainsLink: Bool)] = []
    var missionImageUrlString: String!
    var isBookMarked = false
    var showError: StringClosure
    var updateBookMarkButton: VoidClosure
    var imageURL = ""
    
    init(mission: Mission, missionRepository: MissionRepositoryProtocol = MissionRepository(), reloadTableView: @escaping VoidClosure, showError: @escaping StringClosure, updateBookMarkButton: @escaping VoidClosure) {
        self.mission = mission
        self.missionRepository = missionRepository
        self.reloadTableView = reloadTableView
        self.showError = showError
        self.updateBookMarkButton = updateBookMarkButton
        fillMissionImageUrlString()
        fillDetailsData()
        setIsBookMarked()
    }
}

// MARK: - Action Functions
extension MissionDetailsViewModel {
    
    private func fillDetailsData() {
        if let missionName = mission.name {
            let missionNameTitle =  "Mission Name"
            let missionNameTuple = (missionNameTitle, missionName, false, false)
            detailsData.append(missionNameTuple)
        }

        let detailsTitle = "Details of the mission"
        let details = mission.details ?? "Unfortunately there are no details about this mission!"
        let detailsTuple = (detailsTitle, details, true, false)
        detailsData.append(detailsTuple)
        
        let missionDateTitle = "Execution Date"
        var missionDate = ""
        if let date = mission.dateLocal, let formattedDate = Date.getFormattedDate(from: date) {
            missionDate = formattedDate
        } else {
            missionDate = "no_date_error".localized()
        }
        let missionDateTuple = (missionDateTitle, missionDate, false, false)
        detailsData.append(missionDateTuple)
        
        if let wikipediaLink = mission.links?.wikipedia {
            let wikipediaLinkTitle = "Wikipedia Link"
            let wikipediaLinkTuple = (wikipediaLinkTitle, wikipediaLink,false, true)
            detailsData.append(wikipediaLinkTuple)
        }
        
        reloadTableView()
    }
    
    private func fillMissionImageUrlString() {
        if let urlString = mission.links?.flickr?.original?.first {
            missionImageUrlString = urlString
        } else {
            missionImageUrlString = mission.links?.patch?.large ?? ""
        }
    }
    
    private func setIsBookMarked() {
        do {
            guard let missionID = mission.id else {return}
            isBookMarked = try missionRepository.isMissionBookMarked(withID: missionID)
        } catch {
            showError("Message")
        }
    }
    
    private func setImageURL() {
        if let imageURL = mission.links?.flickr?.original?.first  {
            self.imageURL = imageURL
        } else if let imageURL = mission.links?.patch?.large {
            self.imageURL = imageURL
        } else {
            // show placeholder
        }
    }
    
    func handleBookMarking() {
        isBookMarked.toggle()
        guard let missionID = mission.id else {return}
        do {
            try missionRepository.bookMarkMission(withID: missionID, isBookMarked: isBookMarked)
            updateBookMarkButton()
        } catch {
            showError("Message")
        }
    }
}

