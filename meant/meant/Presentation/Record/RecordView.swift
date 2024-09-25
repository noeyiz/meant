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
    private var textViewBottomConstraint: Constraint?
    
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
    
    let textView = MeantTextView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupKeyboardObservers()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeKeyboardObservers()
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
        
        addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(100)
            make.left.right.equalToSuperview().inset(30)
            textViewBottomConstraint = make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).constraint
        }
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self, 
            selector: #selector(handleKeyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleKeyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Action Functions
    
    @objc private func handleKeyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue 
        else { return }
        
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        UIView.animate(withDuration: 0.3) {
            self.textViewBottomConstraint?.update(inset: keyboardHeight)
            self.layoutIfNeeded()
        }
    }
    
    @objc private func handleKeyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.textViewBottomConstraint?.update(inset: 0)
            self.layoutIfNeeded()
        }
    }
    
    // MARK: - Configure
    
    func configure(with type: RecordType) {
        messageContainer.backgroundColor = type.color01
        messageLabel.setTextWithLineHeight(type.message)
        textView.tintColor = type.color02
    }
    
    func animateMessageAppearance() {
        layoutIfNeeded()
        
        UIView.animate(
            withDuration: 0.8,
            delay: 0.3,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.5,
            options: .curveEaseIn
        ) {
            self.messageContainerHeightConstraint?.update(offset: 70)
            self.textView.becomeFirstResponder()
            self.layoutIfNeeded()
        } completion: { _ in
        }
    }
}
