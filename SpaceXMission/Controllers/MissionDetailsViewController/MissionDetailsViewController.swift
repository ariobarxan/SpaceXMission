//
//  MissionDetailsViewController.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/22/23.
//

import UIKit

final class MissionDetailsViewController: BaseViewController {

    @IBOutlet private(set) weak var headerView: UIView!
    @IBOutlet private(set) weak var missionImageView: WebImageView!
    @IBOutlet private(set) weak var missionDetailsTableView: UITableView!
    @IBOutlet private(set) weak var bookMarkButton: UIButton!
    @IBAction func bookMarkButtonAction(_ sender: UIButton) {
        viewModel.handleBookMarking()
    }
    
    private var viewModel: MissionDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
}

// MARK: - Setup Functions
extension MissionDetailsViewController {
    
    private func setupViews() {
        setupMissionImageView()
        setupTableView()
        setupBookMarkButton()
    }
    
    private func setupMissionImageView() {
        missionImageView.setup(withURLString: viewModel.imageURL, name: viewModel.imageURL)
    }
    
    private func setupTableView() {
        MissionDetailsTableViewCell.register(for: missionDetailsTableView)
        missionDetailsTableView.delegate = self
        missionDetailsTableView.dataSource = self
    }
    
    private func setupBookMarkButton() {
        let imageName = self.viewModel.isBookMarked ? ImageAssets.bookmarkFilled.rawValue : ImageAssets.bookmark.rawValue
        let image = UIImage(systemName: imageName)
        self.bookMarkButton.setImage(image, for: .normal)
    }
}

// MARK: - Action Functions
extension MissionDetailsViewController {
    
    func setup(forMission mission: Mission) {
        viewModel = MissionDetailsViewModel(mission: mission, reloadTableView: { [unowned self] in
            self.reloadTableView()
        }, showError: { [unowned self] message in
            self.showError(message)
        }, updateBookMarkButton: { [unowned self] in
            self.setupBookMarkButton()
        })
    }
    
    private func reloadTableView() {
        mainThread {
            self.missionDetailsTableView.reloadData()
        }
    }
    
    private func showError(_ message: String) {
        // TODO: - Show Error
    }
    
    private func openLinkInBrowser(_ urlString: String) {
        if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:])
        }
    }
}

// MARK: - TableView Delegate and DataSource Functions
extension MissionDetailsViewController: TableViewDataSourceAndDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.detailsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MissionDetailsTableViewCell.identifier, for: indexPath) as! MissionDetailsTableViewCell
    
        cell.setup(withConfig: viewModel.getCellConfig(forIndex: indexPath.row))
        return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = viewModel.detailsData[indexPath.row]
        if detail.valueContainsLink {
            openLinkInBrowser(detail.value)
        }
    }
}
