//
//  HomeViewController.swift
//  meant
//
//  Created by 지연 on 9/25/24.
//

import Combine
import UIKit

final class HomeViewController: BaseViewController<HomeView> {
    private let viewModel: HomeViewModel
    private let recordCellViewModels = RecordType.allCases
    private var cancellables = Set<AnyCancellable>()
    private var allRecordDataSource: UITableViewDiffableDataSource<String, RecordCellViewModel>!
    private var reminiscenceDataSource: UITableViewDiffableDataSource<Int, Reminiscence>!
    
    // MARK: - Init
    
    init(viewModel: HomeViewModel) {
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
        
        setupNavigationBar()
        setupNotificationObserver()
        setupAction()
        setupDelegate()
        bind()
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigationBar() {
        setNavigationBarStyle(.largeTitleWithRightButton)
        setNavigationBarTitle("meant")
        setNavigationBarRightButtonIcon("gearshape")
    }
    
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleRecordsDidUpdate),
            name: .recordsDidUpdate,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleRecordsDidReset),
            name: .recordsDidReset,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleUsernameDidUpdate),
            name: .usernameDidUpdate,
            object: nil
        )
    }
    
    private func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupAction() {
        rightButton.addTarget(
            self,
            action: #selector(handleSettingsButtonTap),
            for: .touchUpInside
        )
        ellipsisButton.addTarget(
            self,
            action: #selector(handleEllipsisButtonTap),
            for: .touchUpInside
        )
    }
    
    private func setupDelegate() {
        recordCardView.delegate = self
        recordCardView.dataSource = self
        
        configureDataSource()
        allRecordTableView.delegate = self
        reminiscenceTableView.delegate = self
    }
    
    private func configureDataSource() {
        allRecordDataSource = UITableViewDiffableDataSource<String, RecordCellViewModel>(
            tableView: allRecordTableView,
            cellProvider: { (tableView, indexPath, cellViewModel) -> UITableViewCell? in
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: RecordCell.self)
                cell.configure(with: cellViewModel)
                return cell
            }
        )
        
        reminiscenceDataSource = UITableViewDiffableDataSource<Int, Reminiscence>(
            tableView: reminiscenceTableView,
            cellProvider: { (tableView, indexPath, reminiscence) -> UITableViewCell? in
                let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ReminiscenceCell.self)
                cell.configure(with: reminiscence)
                return cell
            }
        )
    }
    
    // MARK: - Bind
    
    private func bind() {
        viewModel.$username
            .sink { [weak self] username in
                guard let self = self else { return }
                allRecordEmptyLabel.text = "\(username)님의 기록을 기다리고 있어요."
                randomRecordEmptyLabel.text = "\(username)님의 기록을 기다리고 있어요."
            }.store(in: &cancellables)
        
        viewModel.$records
            .sink { [weak self] records in
                guard let self = self else { return }
                allRecordEmptyLabel.isHidden = !records.isEmpty
                applySnapshot(with: records)
            }
            .store(in: &cancellables)
        
        viewModel.$randomRecord
            .sink { [weak self] record in
                guard let self = self else { return }
                randomRecordView.configure(with: record)
                if let record = record {
                    applySnapshot(with: record.reminiscences)
                }
            }.store(in: &cancellables)
    }
    
    // MARK: - Snapshot Application
    
    private func applySnapshot(with records: [RecordSectionViewModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<String, RecordCellViewModel>()
        
        records.forEach { section in
            snapshot.appendSections([section.month])
            snapshot.appendItems(section.cellViewModels, toSection: section.month)
        }
        
        allRecordDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func applySnapshot(with reminiscences: [Reminiscence]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, Reminiscence>()
        snapshot.appendSections([0])
        snapshot.appendItems(reminiscences, toSection: 0)
        reminiscenceDataSource.apply(snapshot, animatingDifferences: false)
    }
    
    // MARK: - Action Methods
    
    @objc private func handleRecordsDidUpdate() {
        viewModel.updateRecords()
    }
    
    @objc private func handleRecordsDidReset() {
        viewModel.resetRecords()
    }
    
    @objc private func handleUsernameDidUpdate() {
        viewModel.updateUsername()
    }
    
    @objc private func handleSettingsButtonTap() {
        generateHaptic()
        let settingsViewModel = DIContainer.shared.makeSettingsViewModel()
        let settingsViewController = SettingsViewController(viewModel: settingsViewModel)
        navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    @objc private func handleEllipsisButtonTap() {
        generateHaptic()
        
        let recordMenuViewController = RecordMenuViewController(otherFlag: true)
        recordMenuViewController.delegate = self
        recordMenuViewController.modalPresentationStyle = .popover
        
        if let popoverController = recordMenuViewController.popoverPresentationController {
            popoverController.sourceView = ellipsisButton
            popoverController.sourceRect = CGRect(
                x: ellipsisButton.bounds.midX,
                y: ellipsisButton.bounds.midY + 100,
                width: 0,
                height: 0
            )
            popoverController.permittedArrowDirections = []
            popoverController.delegate = self
        }
        
        present(recordMenuViewController, animated: true)
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard tableView == allRecordTableView else { return }
        
        generateHaptic()
        let record = viewModel.records[indexPath.section].cellViewModels[indexPath.row]
        let recordDetailViewModel = DIContainer.shared.makeRecordDetailViewModel(recordID: record.id)
        let recordDetailViewController = RecordDetailViewController(
            viewModel: recordDetailViewModel,
            username: viewModel.username
        )
        navigationController?.pushViewController(recordDetailViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard tableView == allRecordTableView else { return nil }
        
        let label = UILabel()
        label.text = allRecordDataSource.snapshot().sectionIdentifiers[section]
        label.font = .nanumSquareNeo(ofSize: 12.0, weight: .bold)
        label.textColor = .gray02
        let view = UIView()
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        return view
    }
    
    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        guard tableView == reminiscenceTableView else { return nil}
        
        let deleteAction = UIContextualAction(style: .normal, title: "") { (_, _, _) in
            self.generateHaptic()
            self.viewModel.deleteReminiscence(for: indexPath.row)
        }
        deleteAction.backgroundColor = .white
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 8, weight: .bold)
        let image = UIImage(systemName: "trash", withConfiguration: imageConfig)?.withTintColor(.alertWarning, renderingMode: .alwaysOriginal)
        deleteAction.image = image
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = false
        
        return configuration
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let width = (collectionView.frame.width - 15) / 2
        let height = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        let recordViewModel = DIContainer.shared.makeRecordViewModel()
        let type = recordCellViewModels[indexPath.row]
        let recordViewController = RecordViewController(
            viewModel: recordViewModel,
            recordType: type,
            username: viewModel.username
        )
        generateHaptic()
        navigationController?.pushViewController(recordViewController, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return recordCellViewModels.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: RecordCardCell.self)
        cell.configure(with: recordCellViewModels[indexPath.row])
        return cell
    }
}

extension HomeViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension HomeViewController: RecordMenuViewDelegate {
    func didRecordMenuTap(_ recordMenu: RecordMenu) {
        switch recordMenu {
        case .edit:
            guard let record = viewModel.randomRecord else { return }
            let editViewModel = DIContainer.shared.makeEditViewModel(for: record.id)
            let editViewController = EditViewController(
                viewModel: editViewModel,
                username: viewModel.username
            )
            present(editViewController, animated: true)
        case .reminisce:
            guard let record = viewModel.randomRecord else { return }
            let reminiscenceViewModel = DIContainer.shared.makeReminiscenceViewModel(
                recordID: record.id
            )
            let reminiscenceViewController = ReminisceneViewController(
                viewModel: reminiscenceViewModel
            )
            present(reminiscenceViewController, animated: true)
        case .other:
            viewModel.refreshRandomRecord()
        case .delete:
            showAlert(
                message: "정말 삭제하시겠어요?",
                leftActionText: "돌아가기",
                rightActionText: "삭제하기",
                rightActionCompletion: { [weak self] in
                    guard let self = self else { return }
                    viewModel.deleteRandomRecord()
                    dismiss(animated: true)
                },
                isRightDangerous: true
            )
        }
    }
}

private extension HomeViewController {
    var recordCardView: UICollectionView {
        contentView.recordCardView
    }
    
    var randomRecordView: RecordDetailView {
        contentView.myRecordView.randomRecordView
    }
    
    var ellipsisButton: UIButton {
        contentView.myRecordView.randomRecordView.ellipsisButton
    }
    
    var randomRecordEmptyLabel: UILabel {
        contentView.myRecordView.randomRecordView.emptyLabel
    }
    
    var reminiscenceTableView: UITableView {
        contentView.myRecordView.randomRecordView.tableView
    }
    
    var allRecordEmptyLabel: UILabel {
        contentView.myRecordView.allRecordView.emptyLabel
    }
    
    var allRecordTableView: UITableView {
        contentView.myRecordView.allRecordView.tableView
    }
}
