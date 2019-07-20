//
//  ScoreListView.swift
//  Craft_Demo
//
//  Created by Ashis Laha on 7/19/19.
//  Copyright © 2019 Team A. All rights reserved.
//

import UIKit

protocol ScoreListViewDelegate: class {
    func refresh()
}

class ScoreListView: UIView {
    
    public var model: ScoreAnalysis? {
        didSet {
            refreshControl.endRefreshing()
            tableView.reloadData()
        }
    }
    
    public weak var delegate: ScoreListViewDelegate?
    
    // private properties
    private var tableView: UITableView!
    private let cellId = "cellId"
    private let headerId = "headerId"
    
    // RefreshControl
    private let refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return refreshControl
    }()
    
    @objc private func refresh() {
        delegate?.refresh()
    }
    
    // init
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableViewSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        tableViewSetup()
    }
    
    private func tableViewSetup() {
        backgroundColor = .white
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
        tableView.fillSuperView(padding: .init(top: 20, left: 12, bottom: 20, right: 12))
        
        // configure table
        tableView.register(ScoreRangeTableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.register(ScoreRangeTableViewHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.allowsSelection = false
        tableView.refreshControl = refreshControl // pull to refresh
    }
}

extension ScoreListView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.scores.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? ScoreRangeTableViewCell else { return UITableViewCell() }
        
        cell.currentScore = model?.myScore
        cell.model = model?.scores[indexPath.row]
        return cell
    }
}

extension ScoreListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as? ScoreRangeTableViewHeader else { return nil }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
}




