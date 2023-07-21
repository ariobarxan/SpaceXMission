//
//  MissionTableViewCell.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import UIKit

final class MissionTableViewCell: UITableViewCell {
    @IBOutlet private(set) weak var flightNumberLabel: UILabel!
    @IBOutlet private(set) weak var missionIconImageView: UIImageView!
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
        setupFlightNumberLabel()
        setupMissionIconImageView()
        setupDescriptionLabel()
        setupDateLabel()
        setupStatus()
    }
    
    private func setupFlightNumberLabel() {
        flightNumberLabel.text = "\(mission.flightNumber ?? 0) "
    }
    
    private func setupMissionIconImageView() {    }
    
    private func setupDescriptionLabel(){
        descriptionLabel.text = mission.capsules?.description
    }
    
    private func setupDateLabel() {
        dateLabel.text = mission.dateUTC
    }
    
    private func setupStatus() {
        statusLabel.text = (mission.success ?? false) ? "Succeed" : "Failed"
    }
    
}
