//
//  SettingsViewController.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import UIKit

final class SettingsViewController: BaseViewController<SettingsView>, UIGestureRecognizerDelegate {
    private let settings = SettingsType.allCases
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupAction()
        setupTableView()
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
        cell.configure(with: settings[indexPath.row])
        return cell
    }
}

private extension SettingsViewController {
    var tableView: UITableView {
        contentView.tableView
    }
}
