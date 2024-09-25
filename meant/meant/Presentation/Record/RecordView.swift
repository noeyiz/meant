//
//  RecordView.swift
//  meant
//
//  Created by 지연 on 9/25/24.
//

import UIKit

import SnapKit

final class RecordView: UIView {
    private var messageContainerHeightConstraint: Constraint?
    
    // MARK: - UI Components
    
    private let messageContainer = {
        let view = UIView()
        view.clipsToBounds = true
        view.layer.cornerRadius = 30
        return view
    }()
    
    private let messageLabel = {
        let label = UILabel()
        label.font = .nanumSquareNeo(ofSize: 10.5)
        label.textColor = .gray03
        return label
    }()
    
    private let dateLabel = {
        let label = UILabel()
        label.text = Date().formatAsDayWeekday()
        label.font = .nanumSquareNeo(ofSize: 8)
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
        addSubview(messageContainer)
        messageContainer.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(10)
            make.left.right.equalToSuperview().inset(15)
            messageContainerHeightConstraint = make.height.equalTo(0).constraint
        }
        
        messageContainer.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.centerY.equalToSuperview()
        }
        
        messageContainer.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(30)
            make.top.equalTo(messageLabel.snp.top)
        }
    }
    
    // MARK: - Configure
    
    func configure(with type: RecordType) {
        messageContainer.backgroundColor = type.color
        messageLabel.setTextWithLineHeight(type.message)
    }
    
    func animateMessageAppearance() {
        layoutIfNeeded()
        
        UIView.animate(
            withDuration: 1.0,
            delay: 0.5,
            usingSpringWithDamping: 0.8,
            initialSpringVelocity: 0.5,
            options: .curveEaseInOut
        ) {
            self.messageContainerHeightConstraint?.update(offset: 70)
            self.layoutIfNeeded()
        }
    }
}
