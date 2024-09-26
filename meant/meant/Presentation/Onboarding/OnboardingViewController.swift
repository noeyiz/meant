//
//  OnboardingViewController.swift
//  meant
//
//  Created by 지연 on 9/27/24.
//

import UIKit

final class OnboardingViewController: BaseViewController<NameView> {
    private var userSettingsRepository: UserSettingsRepositoryInterface
    private let maxLength = 5
    
    // MARK: - Init
    
    init(userSettingsRepository: UserSettingsRepositoryInterface) {
        self.userSettingsRepository = userSettingsRepository
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupAction()
        textField.becomeFirstResponder()
        rightButton.isEnabled = false
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigationBar() {
        setNavigationBarStyle(.normalTitleWithBothButtons)
        setNavigationBarRightButtonTitle("시작하기")
    }
    
    private func setupAction() {
        rightButton.addTarget(self, action: #selector(handleStartButtonTap), for: .touchUpInside)
        textField.addTarget(self, action: #selector(handleTextFieldUpdate), for: .editingChanged)
    }
    
    // MARK: - Action Methods
    
    @objc private func handleStartButtonTap() {
        generateHaptic()
        userSettingsRepository.username = textField.text!
        userSettingsRepository.onboardingCompleted = true
        
        let homeViewModel = DIContainer.shared.makeHomeViewModel()
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        view.window?.rootViewController = UINavigationController(rootViewController: homeViewController)
    }
    
    @objc private func handleTextFieldUpdate() {
        guard let username = textField.text else { return }
        let count = username.count
        indicatorLabel.text = "\(count)/\(maxLength)"
        rightButton.isEnabled = count <= maxLength && count > 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.endEditing(true)
    }
}

private extension OnboardingViewController {
    var textField: UITextField {
        contentView.textField
    }
    
    var indicatorLabel: UILabel {
        return contentView.indicatorLabel
    }
}
