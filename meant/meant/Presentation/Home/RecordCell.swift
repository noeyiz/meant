//
//  RecordCell.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import UIKit

import SnapKit

final class RecordCell: UITableViewCell, Reusable {
    // MARK: - UI Components
    
    private let containerView = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    private let dateLabel = {
        let label = UILabel()
        label.font = .nanumSquareNeo(ofSize: 8.5)
        label.textColor = .gray02
        return label
    }()
    
    private let contentLabel = {
        let label = UILabel()
        label.font = .nanumSquareNeo(ofSize: 10.5)
        label.textColor = .gray03
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupCell() {
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func setupLayout() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(5)
            make.horizontalEdges.equalToSuperview()
        }
        
        containerView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(25)
        }
        
        containerView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(25)
            make.bottom.equalToSuperview().inset(20)
        }
    }
    
    // MARK: - Configure
    
    func configure(with viewModel: RecordCellViewModel) {
        dateLabel.text = viewModel.date
        contentLabel.setTextWithLineHeight(viewModel.content, lineHeight: 17.0)
        containerView.backgroundColor = viewModel.backgroundColor
    }
}
