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
    private let settings = SettingsType.allCases
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
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Bind
    
    private func bind() {
        viewModel.$notificationEnabled
            .sink { [weak self] isEnabled in
                guard let self = self, isEnabled else { return }
                let notificationViewController = NotificationViewController()
                navigationController?.pushViewController(notificationViewController, animated: true)
            }.store(in: &cancellables)
        
        viewModel.$lockEnabled
            .sink { [weak self] isEnabled in
                guard let self = self, isEnabled else { return }
                let lockViewController = LockViewController()
                navigationController?.pushViewController(lockViewController, animated: true)
            }.store(in: &cancellables)
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let setting = settings[indexPath.row]
        switch setting {
        case .name:
            let nameViewController = NameViewController()
            navigationController?.pushViewController(nameViewController, animated: true)
        case .instragram:
            InstragramLinkHandler.openInstagramProfile()
        default:
            break
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: SettingsCell.self)
        let setting = settings[indexPath.row]
        cell.configure(with: setting)
        cell.switchValueChangedHandler = { [weak self] newValue in
            self?.handleSwitchValueChange(for: setting, newValue: newValue)
        }
        return cell
    }
    
    private func handleSwitchValueChange(for setting: SettingsType, newValue: Bool) {
        switch setting {
        case .notification:
            viewModel.setNotificationStatus(isOn: newValue)
        case .lock:
            viewModel.setLockStatus(isOn: newValue)
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
