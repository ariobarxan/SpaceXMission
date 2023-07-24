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
    @IBOutlet weak var bookMarkButton: UIButton!
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
    
    func setupViews() {
        setupMissionImageView()
        setupTableView()
        setupBookMarkButton()
    }
    
    private func setupMissionImageView() {
        missionImageView.setup(withURLString: viewModel.imageURL, name: viewModel.imageURL)
        print("Amir image")
    }
    
    private func setupTableView() {
        MissionDetailsTableViewCell.register(for: missionDetailsTableView)
        missionDetailsTableView.delegate = self
        missionDetailsTableView.dataSource = self
        // TODO: - Set the right amount for the Insets
    }
    
    private func setupBookMarkButton() {
        let imageName = self.viewModel.isBookMarked ? "bookmark.fill" : "bookmark"
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
            //it crashes some times at this line
            self.missionDetailsTableView.reloadData()
        }
    }
    
    
    private func showError(_ message: String) {}
}

// MARK: - TableView Delegate and DataSource Functions
extension MissionDetailsViewController: TableViewDataSourceAndDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.detailsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MissionDetailsTableViewCell.identifier, for: indexPath) as! MissionDetailsTableViewCell
    
        cell.setup(withConfig: getCellConfig())
        return cell
        
        func getCellConfig() -> MissionDetailsTableViewCell.Config {
            typealias Config = MissionDetailsTableViewCell.Config
            let detail = viewModel.detailsData[indexPath.row]
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = viewModel.detailsData[indexPath.row]
        if detail.valueContainsLink, let url = URL(string: detail.value), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:])
        }
    }
    
    
}
