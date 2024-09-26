//
//  NameViewController.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Combine
import UIKit

final class NameViewController: BaseViewController<NameView>, UIGestureRecognizerDelegate {
    private let viewModel: NameViewModel
    private var cancellables = Set<AnyCancellable>()
    private let maxLength = 5
    
    // MARK: - Init
    
    init(viewModel: NameViewModel) {
        self.viewModel = viewModel
        
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
        bind()
        textField.becomeFirstResponder()
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigationBar() {
        setNavigationBarStyle(.normalTitleWithBothButtons)
        setNavigationBarTitle("이름 설정")
        setNavigationBarLeftButtonIcon("chevron.left")
        setNavigationBarRightButtonTitle("저장")
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func setupAction() {
        leftButton.addTarget(self, action: #selector(handleBackButtonTap), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(handleSaveButtonTap), for: .touchUpInside)
        textField.addTarget(self, action: #selector(handleTextFieldUpdate), for: .editingChanged)
    }
    
    // MARK: - Bind
    
    private func bind() {
        textField.text = viewModel.username
        let count = viewModel.username.count
        indicatorLabel.text = "\(count)/\(maxLength)"
        rightButton.isEnabled = count <= maxLength && count > 0
    }
    
    // MARK: - Action Methods
    
    @objc private func handleBackButtonTap() {
        generateHaptic()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleSaveButtonTap() {
        generateHaptic()
        viewModel.saveName(name: textField.text!)
        navigationController?.popViewController(animated: true)
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

private extension NameViewController {
    var textField: UITextField {
        return contentView.textField
    }
    
    var indicatorLabel: UILabel {
        return contentView.indicatorLabel
    }
}
