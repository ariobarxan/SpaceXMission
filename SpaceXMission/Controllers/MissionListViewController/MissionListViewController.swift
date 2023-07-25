//
//  ViewController.swift
//  SpaceXMission
//
//  Created by Azhman Adam on 7/20/23.
//

import UIKit

final class MissionListViewController: BaseViewController {

    @IBOutlet private(set) weak var headerView: UIView!
    @IBOutlet private(set )weak var missionListTableView: UITableView!
    
    private var viewModel: MissionListViewModel!
    private var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
           
        setupViewModel()
        setupViews()
        
        Task {
            await viewModel.loadData()
        }
    }
    
    deinit{
        Log.d()
    }
}

// MARK: - Setup Functions
extension MissionListViewController {
    
    private func setupViews() {
        setupHeaderView()
        setupRefreshControl()
        setupTableView()
    }
    
    private func setupHeaderView() {
        headerView.backgroundColor = .red
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: UIControl.Event.valueChanged)
    }
    
    private func setupTableView() {
        MissionTableViewCell.register(for: missionListTableView)
        missionListTableView.delegate = self
        missionListTableView.dataSource = self
        missionListTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        missionListTableView.addSubview(refreshControl)
        
    }
    
    private func showError(withMessage message: String) {
        // TODO: - Implement Error Message
    }
    
    private func handleShowLoading(shouldShowLoading: Bool) {
        // TODO: - Implement Loading
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
    
    private func reloadTableView() {
        mainThread {
            self.missionListTableView.reloadData()
        }
    }
    
    @objc private func refreshTableView() {
        Task {
            await self.viewModel.pullToRefreshTableViewAction()
            self.refreshControl.endRefreshing()
        }
    }
}

// MARK: - TableView Delegate and DataSource Functions
extension MissionListViewController: TableViewDataSourceAndDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tableViewMissions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MissionTableViewCell.identifier, for: indexPath) as! MissionTableViewCell
        cell.setup(withMission: viewModel.tableViewMissions[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let mission = viewModel.tableViewMissions[indexPath.row]
        (coordinator as! MainCoordinator).showMissionDetailViewController(forMission: mission)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == viewModel.tableViewMissions.count - 1 {
            Task {
                await viewModel.loadData()
            }
        }
    }
}
