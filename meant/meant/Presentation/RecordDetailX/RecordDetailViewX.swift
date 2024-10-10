//
//  RecordDetailView.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import UIKit

import SnapKit

final class RecordDetailViewX: UIView {
    private var textViewBottomConstraint: Constraint?
    
    // MARK: - UI Components
    
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
        addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(10)
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
}
