//
//  LicenseViewController.swift
//  meant
//
//  Created by 지연 on 10/11/24.
//

import UIKit

final class LicenseViewController: BaseViewController<LicenseView>, UIGestureRecognizerDelegate {
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigatioinBar()
        setupAction()
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigatioinBar() {
        setNavigationBarStyle(.normalTitleWithBothButtons)
        setNavigationBarTitle("오픈소스 라이선스")
        setNavigationBarLeftButtonIcon("chevron.left")
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func setupAction() {
        leftButton.addTarget(self, action: #selector(handleBackButtonTap), for: .touchUpInside)
    }
    
    // MARK: - Action Methods
    
    @objc private func handleBackButtonTap() {
        generateHaptic()
        navigationController?.popViewController(animated: true)
    }
}
