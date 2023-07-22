//
//  MissionDetailsTableViewCell.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/22/23.
//

import UIKit

class MissionDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    private var config: MissionDetailsTableViewCell.Config!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    deinit {
        Log.d()
    }
}

// MARK: - Models
extension MissionDetailsTableViewCell {
    
    enum Config {
        case titleWithDescription(titleText: String, descriptionText: String)
        case titleWithDetailedDescription(titleText: String, detailedDescriptionText: String)
    }
}

// MARK: - Setup Functions
extension MissionDetailsTableViewCell {
    
    func setup(withConfig config: MissionDetailsTableViewCell.Config) {
        self.config = config
        setupViews()
    }
    
    
    private func setupViews() {
        
        switch config {
        case .titleWithDescription(let titleText, let descriptionText):
            titleLabel.text = titleText
            descriptionLabel.isHidden = false
            descriptionLabel.text = descriptionText
            detailLabel.isHidden = true
            detailLabel.text = titleText
            break
        case .titleWithDetailedDescription(let titleText, let detailedDescriptionText):
            titleLabel.text = titleText
            detailLabel.isHidden = false
            detailLabel.text = detailedDescriptionText
            descriptionLabel.isHidden = true

            break
        default:
            // TODO: - Handle
            break
        }
    }
}
