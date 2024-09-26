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
        setNavigationBarTitle("잠금 설정")
        setNavigationBarLeftButtonIcon("chevron.left")
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func setupAction() {
        leftButton.addTarget(self, action: #selector(handleBackButtonTap), for: .touchUpInside)
    }
    
    // MARK: - Action Methods
    
    @objc private func handleBackButtonTap() {
        navigationController?.popViewController(animated: true)
    }
}
