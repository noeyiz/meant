//
//  SettingsViewController.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Combine
import UIKit

final class SettingsViewController: BaseViewController<SettingsView>, UIGestureRecognizerDelegate {
    private let viewModel: SettingsViewModel
    private var settings: [[SettingsCellViewModel]] = [[], []]
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: SettingsViewModel) {
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
        setupTableView()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.fetchSettings()
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigationBar() {
        setNavigationBarStyle(.normalTitleWithBothButtons)
        setNavigationBarTitle("설정")
        setNavigationBarLeftButtonIcon("chevron.left")
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func setupAction() {
        leftButton.addTarget(self, action: #selector(handleBackButtonTap), for: .touchUpInside)
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Action Methods
    
    @objc private func handleBackButtonTap() {
        generateHaptic()
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Bind
    
    private func bind() {
        viewModel.$showNotificationSettings
            .sink { [weak self] show in
                guard let self = self, show else { return }
                let notificationViewModel = DIContainer.shared.makeNotificationViewModel()
                let notificationViewController = NotificationViewController(
                    viewModel: notificationViewModel
                )
                navigationController?.pushViewController(notificationViewController, animated: true)
            }.store(in: &cancellables)
        
        viewModel.$settings
            .sink { [weak self] settings in
                guard let self = self else { return }
                self.settings = settings
                tableView.reloadData()
            }.store(in: &cancellables)
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setting = settings[indexPath.section][indexPath.row]
        guard setting.type.mode != .switchControl else { return }
        
        generateHaptic()
        switch setting.type {
        case .name:
            let nameViewModel = DIContainer.shared.makeNameViewModel()
            let nameViewController = NameViewController(viewModel: nameViewModel)
            navigationController?.pushViewController(nameViewController, animated: true)
        case .reset:
            showAlert(
                message: "모든 기록이 영원히 사라져요.\n정말 삭제하시겠어요?",
                leftActionText: "돌아가기",
                rightActionText: "삭제하기",
                rightActionCompletion: {
                    NotificationCenter.default.post(name: .recordsDidReset, object: nil)
                    self.navigationController?.popViewController(animated: true)
                }
            )
        case .lisence:
            let licenseViewController = LicenseViewController()
            navigationController?.pushViewController(licenseViewController, animated: true)
        default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SettingsCell.self)
        let setting = settings[indexPath.section][indexPath.row]
        cell.configure(with: setting)
        cell.switchValueChangedHandler = { [weak self] newValue in
            self?.handleSwitchValueChange(for: setting.type, newValue: newValue)
        }
        return cell
    }
    
    private func handleSwitchValueChange(for setting: SettingsType, newValue: Bool) {
        switch setting {
        case .notification:
            viewModel.setNotificationStatus(isOn: newValue)
        default:
            break
        }
    }
}

private extension SettingsViewController {
    var tableView: UITableView {
        contentView.tableView
    }
}
