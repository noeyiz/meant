//
//  NotificationView.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import UIKit

import SnapKit

final class NotificationView: UIView {
    // MARK: - UI Component
    
    private let previewContainerView = {
        let view = UIView()
        view.backgroundColor = .tertiarySystemGroupedBackground
        view.clipsToBounds = true
        view.layer.cornerRadius = 25
        view.overrideUserInterfaceStyle = .light
        return view
    }()
    
    private let appIconImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "meant")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        return imageView
    }()
    
    private let appNameLabel = {
        let label = UILabel()
        label.text = "meant"
        label.font = .boldSystemFont(ofSize: 13.5)
        label.textColor = .black
        return label
    }()
    
    let timeLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11.5)
        label.textColor = .systemGray
        return label
    }()
    
    let messageLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11.5)
        label.textColor = .black
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var timeTitleLabel = createTitleLabel(with: "알림 시간")
    
    let timePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
        picker.locale = Locale(identifier: "ko_KR")
        picker.minuteInterval = 15
        picker.preferredDatePickerStyle = .wheels
        picker.overrideUserInterfaceStyle = .light
        picker.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        return picker
    }()
    
    private lazy var messageTitleLabel = createTitleLabel(with: "알림 메시지")
    
    let messageTextfield = {
        let textField = UITextField()
        textField.font = .nanumSquareNeo(ofSize: 12.0)
        textField.placeholder = "하루의 의미를 찾는 시간, 어떤 문장으로 알려드릴까요?"
        textField.textColor = .gray03
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.clearButtonMode = .always
        textField.tintColor = .meant02
        return textField
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
        addSubview(previewContainerView)
        previewContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
            make.left.right.equalToSuperview().inset(10)
            make.height.equalTo(75)
        }
        
        previewContainerView.addSubview(appIconImageView)
        appIconImageView.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.left.equalToSuperview().inset(15)
            make.centerY.equalToSuperview()
        }
        
        previewContainerView.addSubview(appNameLabel)
        appNameLabel.snp.makeConstraints { make in
            make.top.equalTo(appIconImageView.snp.top)
            make.left.equalTo(appIconImageView.snp.right).offset(15)
        }
        
        previewContainerView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(appNameLabel.snp.centerY)
            make.right.equalToSuperview().inset(15)
        }
        
        previewContainerView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(appNameLabel.snp.bottom)
            make.bottom.equalTo(appIconImageView.snp.bottom)
            make.left.equalTo(appIconImageView.snp.right).offset(15)
            make.right.equalToSuperview().inset(15)
        }
        
        addSubview(timeTitleLabel)
        timeTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(previewContainerView.snp.bottom).offset(25)
            make.left.equalToSuperview().inset(30)
        }
        
        addSubview(timePicker)
        timePicker.snp.makeConstraints { make in
            make.top.equalTo(timeTitleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(100)
        }
        
        addSubview(messageTitleLabel)
        messageTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(timePicker.snp.bottom).offset(25)
            make.left.equalToSuperview().inset(30)
        }
        
        addSubview(messageTextfield)
        messageTextfield.snp.makeConstraints { make in
            make.top.equalTo(messageTitleLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(35)
        }
    }
}

private extension NotificationView {
    func createTitleLabel(with title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.font = .nanumSquareNeo(ofSize: 13.0, weight: .bold)
        label.textColor = .gray03
        return label
    }
}
