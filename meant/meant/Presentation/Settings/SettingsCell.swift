//
//  SettingsCel.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import UIKit

import SnapKit

final class SettingsCell: UITableViewCell, Reusable {
    var switchValueChangedHandler: ((Bool) -> Void)?
    
    // MARK: - UI Components
    
    private let titleLabel = {
        let label = UILabel()
        label.font = .nanumSquareNeo(ofSize: 13.0)
        label.textColor = .gray03
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
    
    let switchControl = {
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        switchValueChangedHandler = nil
        chevronImageView.isHidden = false
        switchControl.isHidden = false
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
        
        contentView.addSubview(switchControl)
        switchControl.snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(25)
            make.right.equalToSuperview().inset(1)
            make.centerY.equalToSuperview()
        }
    }
    
    // MARK: - Configure
    
    func configure(with viewModel: SettingsCellViewModel) {
        titleLabel.text = viewModel.type.title
        switch viewModel.type.mode {
        case .description:
            switchControl.isHidden = true
        case .switchControl:
            chevronImageView.isHidden = true
            switchControl.isOn = viewModel.isOn!
            switchControl.addTarget(
                self,
                action: #selector(handleSwitchValueChanged),
                for: .valueChanged
            )
        }
    }
    
    @objc private func handleSwitchValueChanged(_ sender: UISwitch) {
        switchValueChangedHandler?(sender.isOn)
    }
}
