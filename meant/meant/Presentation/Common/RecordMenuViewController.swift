//
//  RecordMenuViewController.swift
//  meant
//
//  Created by 지연 on 10/11/24.
//

import UIKit

import SnapKit

final class RecordMenuViewController: UIViewController {
    private let recordMenus = RecordMenu.allCases
    
    // MARK: - UI Components
    
    private lazy var menuTableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.register(cellType: RecordMenuCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        preferredContentSize = CGSize(width: 140.0, height: 160.0)
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        view.addSubview(menuTableView)
        menuTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}

extension RecordMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

extension RecordMenuViewController: UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return recordMenus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: RecordMenuCell.self)
        cell.configure(with: recordMenus[indexPath.row])
        return cell
    }
}
