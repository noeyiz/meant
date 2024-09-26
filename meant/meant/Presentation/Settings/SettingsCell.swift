//
//  SettingsCel.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import UIKit

import SnapKit

final class SettingsCell: UITableViewCell, Reusable {
    // MARK: - UI Components
    
    private let titleLabel = {
        let label = UILabel()
        label.font = .nanumSquareNeo(ofSize: 12.0)
        label.textColor = .gray03
        return label
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.font = .nanumSquareNeo(ofSize: 11.0)
        label.textColor = .gray02
        return label
    }()
    
    private let chevronImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "chevron.right")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .gray02
        return imageView
    }()
    
    private let switchControl = {
        let view = UISwitch()
        view.onTintColor = .blue02
        view.contentMode = .scaleAspectFit
        return view
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
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.centerY.equalToSuperview()
        }
        
        contentView.addSubview(chevronImageView)
        chevronImageView.snp.makeConstraints { make in
            make.width.height.equalTo(12)
            make.right.equalToSuperview().inset(5)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.right.equalTo(chevronImageView.snp.left).offset(-10)
            make.centerY.equalToSuperview()
        }
        
        contentView.addSubview(switchControl)
        switchControl.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(25)
            make.right.equalToSuperview().inset(1)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Configure
    
    func configure(with type: SettingsType) {
        titleLabel.text = type.title
        switch type.mode {
        case .description:
            switchControl.isHidden = true
        case .switchControl:
            descriptionLabel.isHidden = true
            chevronImageView.isHidden = true
        }
    }
}
