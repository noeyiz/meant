//
//  RecordDetailView.swift
//  meant
//
//  Created by 지연 on 10/11/24.
//

import UIKit

import SnapKit

final class RecordDetailView: UIView {
    // MARK: - UI Components
    
    private let dateLabel = {
        let label = UILabel()
        label.font = .nanumSquareNeo(ofSize: 9)
        label.textColor = .gray03
        return label
    }()
    
    let ellipsisButton = {
        let button = UIButton()
        button.configuration = .plain()
        button.configuration?.contentInsets = .zero
        button.configuration?.image = UIImage(systemName: "ellipsis")
        button.configuration?.preferredSymbolConfigurationForImage = .init(pointSize: 11)
        button.tintColor = .gray03
        return button
    }()
    
    private let containerView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let contentLabel = {
        let label = UILabel()
        label.font = .nanumSquareNeo(ofSize: 10.5)
        label.textColor = .gray03
        label.numberOfLines = 0
        return label
    }()
    
    let tableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(cellType: ReminiscenceCell.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderTopPadding = 0
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    let emptyLabel = {
        let label = UILabel()
        label.font = .nanumSquareNeo(ofSize: 10.0)
        label.textColor = .gray02
        return label
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
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.left.equalToSuperview().inset(30)
        }
        
        addSubview(ellipsisButton)
        ellipsisButton.snp.makeConstraints { make in
            make.centerY.equalTo(dateLabel)
            make.right.equalToSuperview().inset(30)
        }
        
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview().inset(30)
        }
        
        containerView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(20)
            make.left.right.equalToSuperview().inset(25)
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom)
            make.left.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview()
        }
        
        addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Configure
    
    func configure(with record: Record?) {
        if let record = record {
            dateLabel.text = record.date.formatAsFullDate()
            contentLabel.setTextWithLineHeight(record.content, lineHeight: 17.0)
            containerView.backgroundColor = RecordType(rawValue: record.type)!.color01
            emptyLabel.isHidden = true
            [dateLabel, ellipsisButton, containerView].forEach { $0.isHidden = false }
        } else {
            emptyLabel.isHidden = false
            [dateLabel, ellipsisButton, containerView].forEach { $0.isHidden = true }
        }
    }
}
