//
//  ReminiscenceView.swift
//  meant
//
//  Created by 지연 on 10/11/24.
//

import UIKit

import SnapKit

final class ReminiscenceView: UIView {
    private var textViewBottomConstraint: Constraint?
    
    // MARK: - UI Components
    
    private let dateLabel = {
        let label = UILabel()
        label.font = .nanumSquareNeo(ofSize: 9)
        label.textColor = .gray03
        return label
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
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.left.equalToSuperview().inset(30)
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
        
        addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(25)
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
    
    func configure(with record: Record) {
        dateLabel.text = record.date.formatAsFullDate()
        contentLabel.setTextWithLineHeight(record.content, lineHeight: 17.0)
        containerView.backgroundColor = RecordType(rawValue: record.type)!.color01
    }
}
