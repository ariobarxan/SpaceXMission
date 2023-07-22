//
//  MissionDetailTableViewCell.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/21/23.
//

import UIKit

final class MissionDetailTableViewCell: UITableViewCell {
    //@IBOutlet private(set) weak var tileLabel: UILabel!
   // @IBOutlet private(set) weak var descriptionLabel: UILabel!
    @IBOutlet private(set) weak var detailedDescriptionLabel: UILabel!
    
    private var config: MissionDetailTableViewCell.Config!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()

    }
}

// MARK: - Models
extension MissionDetailTableViewCell {
    
    enum Config {
        case titleWithDescription(titleText: String, descriptionText: String)
        case titleWithDetailedDescription(titleText: String, detailedDescriptionText: String)
    }
}

// MARK: - Setup Functions
extension MissionDetailTableViewCell {
    
    func setup(withConfig config: MissionDetailTableViewCell.Config) {
        self.config = config
        setupViews()
    }
    
    private func setupViews() {
        detailedDescriptionLabel.text = "case .titleWithDescription(let titleText, let descriptionText):case .titleWithDescription(let titleText, let descriptionText):case .titleWithDescription(let titleText, let descriptionText):case .titleWithDescription(let titleText, let descriptionText):case .titleWithDescription(let titleText, let descriptionText):case .titleWithDescription(let titleText, let descriptionText):case .titleWithDescription(let titleText, let descriptionText):case .titleWithDescription(let titleText, let descriptionText):"
//        switch config {
//        case .titleWithDescription(let titleText, let descriptionText):
//            tileLabel.text = titleText
//            descriptionLabel.isHidden = false
//            descriptionLabel.text = descriptionText
//            detailedDescriptionLabel.isHidden = true
//            detailedDescriptionLabel.text = titleText
//            break
//        case .titleWithDetailedDescription(let titleText, let detailedDescriptionText):
//            tileLabel.text = titleText
//            detailedDescriptionLabel.isHidden = false
//            detailedDescriptionLabel.text = detailedDescriptionText
//            descriptionLabel.isHidden = true
//
//            break
//        default:
//            // TODO: - Handle
//            break
//        }
    }
    
}
