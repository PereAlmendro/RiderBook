//
//  HomeViewController.swift
//  RiderBook
//
//  Created by Pere Almendro on 24/03/2020.
//  Copyright © 2020 Pere Almendro. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController<HomePresenter> {

    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Rider book"
        setupTableView()
        tableView.reloadData()
    }
    
    // MARK : - Private methods
    
    private func setupTableView() {
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(HomeTableViewCell.nib,
                           forCellReuseIdentifier: HomeTableViewCell.identifier)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier,
                                                 for: indexPath) as? HomeTableViewCell ?? HomeTableViewCell()
        
        let view = presenter.dataSource[indexPath.row]
        cell.configureCell(with: view)
        
        return cell
    }
}
