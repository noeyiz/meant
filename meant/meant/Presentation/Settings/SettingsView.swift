//
//  SettingsView.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import UIKit

import SnapKit

final class SettingsView: UIView {
    // MARK: - UI Components
    
    let tableView = {
        let tableViw = UITableView()
        tableViw.register(cellType: SettingsCell.self)
        tableViw.backgroundColor = .clear
        tableViw.separatorStyle = .none
        tableViw.rowHeight = 50
        return tableViw
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(30)
        }
    }
}
