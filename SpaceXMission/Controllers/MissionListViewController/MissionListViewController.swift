//
//  ViewController.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import UIKit

final class MissionListViewController: BaseViewController {
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var missionListTableView: UITableView!
    
    private var viewModel: MissionListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
           
        setupViewModel()
        setupViews()
    }
    
    deinit{
        Log.d()
    }
}

// MARK: - Setup Functions
extension MissionListViewController {
    
    func setupViews() {
        setupHeaderView()
        setupTableView()
    }
    
    private func setupHeaderView() {
        headerView.backgroundColor = .red
    }
    
    private func setupTableView() {
        MissionTableViewCell.register(for: missionListTableView)
        missionListTableView.delegate = self
        missionListTableView.dataSource = self
        // TODO: - Set the right amount for the Insets
        missionListTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
    }
    
    
    private func reloadTableView() {
        mainThread {
            self.missionListTableView.reloadData()
        }
    }
    
    private func showError(withMessage message: String) {
        
    }
    
    private func handleShowLoading(shouldShowLoading: Bool) {
        
    }
}


// MARK: - Action Functions
extension MissionListViewController {
    
    private func setupViewModel() {
        viewModel = MissionListViewModel(
            reloadTableView: { [unowned self] in
                self.reloadTableView()
            },
            showError: { [unowned self] message in
                self.showError(withMessage: message)
            },
            handleShowLoading: { [unowned self] shouldShowLoading in
                self.handleShowLoading(shouldShowLoading: shouldShowLoading)
            })
    }
}

// MARK: - TableView Delegate and DataSource Functions
extension MissionListViewController: TableViewDataSourceAndDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.missions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MissionTableViewCell.identifier, for: indexPath) as! MissionTableViewCell
        cell.setup(withMission: viewModel.missions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
