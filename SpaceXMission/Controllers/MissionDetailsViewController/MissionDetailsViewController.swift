//
//  MissionDetailsViewController.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/22/23.
//

import UIKit

class MissionDetailsViewController: BaseViewController {
    var b = false
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
        missionImageView.setup(withURLString: "https://images2.imgbox.com/33/2e/k6VE4iYl_o.png", name: "https://images2.imgbox.com/33/2e/k6VE4iYl_o.png")
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
