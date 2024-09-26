//
//  NotificationViewController.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import UIKit

final class NotificationViewController: BaseViewController<NotificationView>, UIGestureRecognizerDelegate {
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupAction()
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigationBar() {
        setNavigationBarStyle(.normalTitleWithBothButtons)
        setNavigationBarTitle("알림 설정")
        setNavigationBarLeftButtonIcon("chevron.left")
        setNavigationBarRightButtonTitle("저장")
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func setupAction() {
        leftButton.addTarget(self, action: #selector(handleBackButtonTap), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(handleSaveButtonTap), for: .touchUpInside)
    }
    
    // MARK: - Action Methods
    
    @objc private func handleBackButtonTap() {
        generateHaptic()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleSaveButtonTap() {
        generateHaptic()
        navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageTextField.endEditing(true)
    }
}

private extension NotificationViewController {
    var timeLabel: UILabel {
        contentView.timeLabel
    }
    
    var messageLabel: UILabel {
        contentView.messageLabel
    }
    
    var timePicker: UIDatePicker {
        contentView.timePicker
    }
    
    var messageTextField: UITextField {
        contentView.messageTextfield
    }
}
