//
//  NotificationViewController.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Combine
import UIKit

final class NotificationViewController: BaseViewController<NotificationView>, UIGestureRecognizerDelegate {
    private let viewModel: NotificationViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: NotificationViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeNotificationObserver()
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkNotification()
        setupNavigationBar()
        setupNotificationObserver()
        setupAction()
        bind()
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
    
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleWillEnterForeground),
            name: UIApplication.willEnterForegroundNotification,
            object: nil
        )
    }
    
    private func removeNotificationObserver(){
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupAction() {
        leftButton.addTarget(self, action: #selector(handleBackButtonTap), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(handleSaveButtonTap), for: .touchUpInside)
        messageTextField.addTarget(self, action: #selector(handleMessageUpdate), for: .editingChanged)
        timePicker.addTarget(self, action: #selector(handleTimeUpdate), for: .valueChanged)
    }
    
    private func checkNotification() {
        UserNotificationManager.shared.checkNotificationAuthorization { [weak self] isAuthorized in
            guard let self = self, !isAuthorized else { return }
            showAlert(
                message: "알림 설정을 위해 권한이 필요합니다.\n언제든지 이를 변경할 수 있어요.",
                leftActionText: "그만두기",
                rightActionText: "이동하기",
                leftActionCompletion: {
                    self.navigationController?.popViewController(animated: true)
                },
                rightActionCompletion: {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }
            )
        }
    }
    
    // MARK: - Bind
    
    private func bind() {
        timePicker.date = viewModel.time
        messageTextField.text = viewModel.message
        
        viewModel.$time
            .sink { [weak self] time in
                guard let self = self else { return }
                timeLabel.text = time.formatAsTime()
            }.store(in: &cancellables)
        
        viewModel.$message
            .sink { [weak self] message in
                guard let self = self else { return }
                messageLabel.text = message
                rightButton.isEnabled = !message.isEmpty
            }.store(in: &cancellables)
    }
    
    // MARK: - Action Methods
    
    @objc private func handleWillEnterForeground() {
        checkNotification()
    }
    
    @objc private func handleBackButtonTap() {
        generateHaptic()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleSaveButtonTap() {
        generateHaptic()
        viewModel.saveNotification()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleMessageUpdate() {
        viewModel.updateMessage(messageTextField.text!)
    }
    
    @objc private func handleTimeUpdate() {
        viewModel.updateTime(timePicker.date)
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
