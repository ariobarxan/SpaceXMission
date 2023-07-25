//
//  MissionDetailsViewModel.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/21/23.
//

import Foundation

final class MissionDetailsViewModel {
    
    var detailsData: [(key: String, value: String, isVerticallyFormatted: Bool, valueContainsLink: Bool)] = []
    var isBookMarked = false
    var imageURL = ""
    
    private var missionImageUrlString: String?
    private var missionRepository: MissionRepositoryProtocol
    private var mission: Mission
    private var reloadTableView: VoidClosure
    private var showError: StringClosure
    private var updateBookMarkButton: VoidClosure
    
    init(mission: Mission, missionRepository: MissionRepositoryProtocol = MissionRepository(), reloadTableView: @escaping VoidClosure, showError: @escaping StringClosure, updateBookMarkButton: @escaping VoidClosure) {
        self.mission = mission
        self.missionRepository = missionRepository
        self.reloadTableView = reloadTableView
        self.showError = showError
        self.updateBookMarkButton = updateBookMarkButton
        fillMissionImageUrlString()
        setDetailsData()
        setIsBookMarked()
        setImageURL()
    }
}

// MARK: - Action Functions
extension MissionDetailsViewModel {
    
    private func setDetailsData() {
        if let missionName = mission.name {
            let missionNameTitle =  "mission_name".localized()
            let missionNameTuple = (missionNameTitle, missionName, false, false)
            detailsData.append(missionNameTuple)
        }

        let detailsTitle = "mission_details".localized()
        let details = mission.details ?? "no_mission_detail_error".localized()
        let detailsTuple = (detailsTitle, details, true, false)
        detailsData.append(detailsTuple)
        
        let missionDateTitle = "execution_date".localized()
        var missionDate = ""
        if let date = mission.dateLocal, let formattedDate = Date.getFormattedDate(from: date) {
            missionDate = formattedDate
        } else {
            missionDate = "no_date_error".localized()
        }
        let missionDateTuple = (missionDateTitle, missionDate, false, false)
        detailsData.append(missionDateTuple)
        
        if let wikipediaLink = mission.links?.wikipedia {
            let wikipediaLinkTitle = "wikipedia_link".localized()
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
            // TODO:
            showError("Message")
        }
    }
    
    private func setImageURL() {
        if let imageURL = mission.links?.flickr?.original?.first  {
            self.imageURL = imageURL
        } else if let imageURL = mission.links?.patch?.large {
            self.imageURL = imageURL
        }
    }
    
    func handleBookMarking() {
        isBookMarked.toggle()
        guard let missionID = mission.id else {return}
        do {
            try missionRepository.bookMarkMission(withID: missionID)
            updateBookMarkButton()
        } catch {
            // TODO: 
            showError("Message")
        }
    }
    
    func getCellConfig(forIndex index: Int) -> MissionDetailsTableViewCell.Config {
        typealias Config = MissionDetailsTableViewCell.Config
        let detail = detailsData[index]
        let key = detail.key
        let value = detail.value
        let shouldBeFormattedVertically = detail.isVerticallyFormatted
        let valueIsLink = detail.valueContainsLink

        var config: Config
        
        if valueIsLink {
            config = Config.singleLink(linkText: key)
        } else {
            config = shouldBeFormattedVertically ? MissionDetailsTableViewCell.Config.titleWithDetailedDescription(titleText: key, detailedDescriptionText: value) : MissionDetailsTableViewCell.Config.titleWithDescription(titleText: key, descriptionText: value)
        }
    
        return config
    }
}

