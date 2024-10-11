//
//  RecordMenuCell.swift
//  meant
//
//  Created by 지연 on 10/11/24.
//

import UIKit

import SnapKit

final class RecordMenuCell: UITableViewCell, Reusable {
    // MARK: - UI Components
    
    private let iconImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.font = .nanumSquareNeo(ofSize: 10.0)
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        contentView.addSubview(iconImageView)
        iconImageView.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.width.height.equalTo(12)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(iconImageView.snp.right).offset(10)
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Configure
    
    func configure(with recordMenu: RecordMenu) {
        iconImageView.image = UIImage(systemName: recordMenu.iconName)
        iconImageView.tintColor = recordMenu.color
        titleLabel.text = recordMenu.title
        titleLabel.textColor = recordMenu.color
    }
}
