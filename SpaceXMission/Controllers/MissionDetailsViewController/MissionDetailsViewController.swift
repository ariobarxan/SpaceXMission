//
//  MissionDetailsViewController.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/22/23.
//

import UIKit

class MissionDetailsViewController: BaseViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var missionImageView: WebImageView!
    @IBOutlet weak var missionDetailsTableView: UITableView!
    
    private var viewModel: MissionDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
}

// MARK: - Setup Functions
extension MissionDetailsViewController {
    
    func setupViews() {
        setupMissionImageView()
        setupTableView()
    }
    
    
    private func setupMissionImageView() {
        missionImageView.setup(withURLString: "https://images2.imgbox.com/33/2e/k6VE4iYl_o.png", name: "https://images2.imgbox.com/33/2e/k6VE4iYl_o.png")
    }
    
    private func setupTableView() {
        MissionDetailsTableViewCell.register(for: missionDetailsTableView)
        missionDetailsTableView.delegate = self
        missionDetailsTableView.dataSource = self
        // TODO: - Set the right amount for the Insets
    }
}

extension MissionDetailsViewController {
    
    func setup(forMission mission: Mission) {
        viewModel = MissionDetailsViewModel(mission: mission) { [unowned self] in
            self.reloadTableView()
        }
    }
    
    private func reloadTableView() {
        mainThread {
            self.missionDetailsTableView.reloadData()
        }
    }
}

// MARK: - TableView Delegate and DataSource Functions
extension MissionDetailsViewController: TableViewDataSourceAndDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.detailsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detail = viewModel.detailsData[indexPath.row]
        let title = detail.title
        let description = detail.description
        let shouldBeFormattedVertically = detail.isVerticallyFormatted
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MissionDetailsTableViewCell.identifier, for: indexPath) as! MissionDetailsTableViewCell
        
        let config = shouldBeFormattedVertically ? MissionDetailsTableViewCell.Config.titleWithDetailedDescription(titleText: title, detailedDescriptionText: description) : MissionDetailsTableViewCell.Config.titleWithDescription(titleText: title, descriptionText: description)
        
        cell.setup(withConfig: config)
        return cell
    }
    
}
