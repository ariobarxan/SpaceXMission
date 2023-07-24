//
//  MissionTableViewCell.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import UIKit

final class MissionTableViewCell: UITableViewCell {
    @IBOutlet private(set) weak var flightNumberLabel: UILabel!
    @IBOutlet private(set) weak var missionIconImageView: WebImageView!
    @IBOutlet private(set) weak var descriptionLabel: UILabel!
    @IBOutlet private(set) weak var dateLabel: UILabel!
    @IBOutlet private(set) weak var statusLabel: UILabel!
    
    private var mission: Mission!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension MissionTableViewCell {
    
    func setup(withMission mission: Mission) {
        self.mission = mission
        setupViews()
    }
    
    private func setupViews() {
        self.selectionStyle = .none
        setupFlightNumberLabel()
        setupMissionIconImageView()
        setupDescriptionLabel()
        setupDateLabel()
        setupStatus()
    }
    
    private func setupFlightNumberLabel() {
        flightNumberLabel.text = "flight_number".localized() + "\(mission.flightNumber ?? 0)"
    }
    
    private func setupMissionIconImageView() {
        let imageURLString = mission.links?.patch?.small ?? ""
        missionIconImageView.setup(withURLString: imageURLString, name: mission.id!)
    }
    
    private func setupDescriptionLabel(){
        descriptionLabel.text = mission.details ?? "no_mission_detail_error".localized()
    }
    
    private func setupDateLabel() {
        if let date = mission.dateLocal, let formattedDate = Date.getFormattedDate(from: date)  {
            dateLabel.text = "mission_date".localized() + formattedDate
        } else {
            dateLabel.text = "no_date_error".localized()
        }
    }
    
    private func setupStatus() {
        let missionStatus = (mission.success ?? false) ? "Succeed" : "Failed"
        statusLabel.text = "mission_status".localized() + missionStatus
    }
}
