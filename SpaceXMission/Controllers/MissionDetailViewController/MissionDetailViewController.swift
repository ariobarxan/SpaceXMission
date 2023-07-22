//
//  MissionDetailViewController.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/21/23.
//

import UIKit

final class MissionDetailViewController: BaseViewController {

    @IBOutlet private(set) weak var headerView: UIView!
    @IBOutlet private(set) weak var missionImageView: WebImageView!
    @IBOutlet private(set) weak var detailsTableView: UITableView!
    @IBOutlet private(set) weak var bookmarkButton: UIButton!
    @IBAction func bookMarkActionButton(_ sender: UIButton) {
        Log.d()
    }

    private var viewModel: MissionDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        self.detailsTableView.rowHeight = UITableView.automaticDimension
           self.detailsTableView.estimatedRowHeight = 150
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.detailsTableView.reloadData()
            print("reload")
        }
    }
    
    deinit {
        Log.d()
    }
}

// MARK: - Setup Functions
extension MissionDetailViewController {
    
    func setupViews() {
        setupHeaderView()
        setupMissionImageView()
        setupDetailTableView()
        setupBookMarkButton()
    }
    
    private func setupHeaderView() {
        headerView.backgroundColor = .red
    }
    
    private func setupMissionImageView() {
        missionImageView.setup(withURLString: viewModel.missionImageUrlString, name: viewModel.mission.id! + viewModel.missionImageUrlString)
    }
    
    private func setupDetailTableView() {
        MissionDetailTableViewCell.register(for: detailsTableView)
        detailsTableView.delegate = self
        detailsTableView.dataSource = self
        // TODO: - Set the right amount for the Insets
        detailsTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        
    }
    
    private func setupBookMarkButton() {
        
    }
}

// MARK: - Action Functions
extension MissionDetailViewController {
    
    func setup(forMission mission: Mission) {
        viewModel = MissionDetailsViewModel(mission: mission) { [unowned self] in
            self.reloadTableView()
        }
    }
    
    private func reloadTableView() {
        mainThread {
            self.detailsTableView.reloadData()
        }
    }
}

extension MissionDetailViewController:  TableViewDataSourceAndDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.detailsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let detail = viewModel.detailsData[indexPath.row]
        let title = detail.title
        let description = detail.description
        let shouldBeFormattedVertically = detail.isVerticallyFormatted
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MissionDetailTableViewCell.identifier, for: indexPath) as! MissionDetailTableViewCell
        
        let config = shouldBeFormattedVertically ? MissionDetailTableViewCell.Config.titleWithDetailedDescription(titleText: title, detailedDescriptionText: description) : MissionDetailTableViewCell.Config.titleWithDescription(titleText: title, descriptionText: description)
        
        cell.setup(withConfig: config)
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
