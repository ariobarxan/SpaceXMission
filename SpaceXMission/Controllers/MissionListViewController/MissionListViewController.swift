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
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        setupViews()
        
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
}

// MARK: - TableView Delegate and DataSource Functions
extension MissionListViewController: TableViewDataSourceAndDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MissionTableViewCell.identifier, for: indexPath) as! MissionTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
