//
//  MissionDetailsTableViewCell.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/22/23.
//

import UIKit

final class MissionDetailsTableViewCell: UITableViewCell {

    @IBOutlet private(set) weak var titleLabel: UILabel!
    @IBOutlet private(set) weak var descriptionLabel: UILabel!
    @IBOutlet private(set) weak var detailLabel: UILabel!
    
    private var config: MissionDetailsTableViewCell.Config!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}

// MARK: - Models
extension MissionDetailsTableViewCell {
    
    enum Config {
        case singleLink(linkText: String)
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
        self.selectionStyle = .none
        switch config {
        case .titleWithDescription(let titleText, let descriptionText):
            titleLabel.isHidden = false
            descriptionLabel.isHidden = false
            detailLabel.isHidden = true
            titleLabel.text = titleText
            titleLabel.textColor = .black
            descriptionLabel.text = descriptionText
            detailLabel.text = titleText
            break
        case .titleWithDetailedDescription(let titleText, let detailedDescriptionText):
            titleLabel.isHidden = false
            detailLabel.isHidden = false
            descriptionLabel.isHidden = true
            titleLabel.text = titleText
            titleLabel.textColor = .black
            detailLabel.text = detailedDescriptionText
            break
        case .singleLink(let linkText):
            titleLabel.isHidden = false
            detailLabel.isHidden = true
            descriptionLabel.isHidden = true
            titleLabel.text = linkText
            titleLabel.textColor = .blue

        default:
            break
        }
    }
}
