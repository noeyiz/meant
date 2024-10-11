//
//  RecordDetailViewController.swift
//  meant
//
//  Created by 지연 on 10/11/24.
//

import Combine
import UIKit

final class RecordDetailViewController: BaseViewController<RecordDetailView>, UIGestureRecognizerDelegate {
    private let viewModel: RecordDetailViewModel
    private let username: String
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: RecordDetailViewModel, username: String) {
        self.viewModel = viewModel
        self.username = username
        
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
        bind()
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigationBar() {
        setNavigationBarStyle(.normalTitleWithBothButtons)
        setNavigationBarTitle("\(username)의 기록")
        setNavigationBarLeftButtonIcon("chevron.left")
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func setupNotificationObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleRecordsDidUpdate),
            name: .recordsDidUpdate,
            object: nil
        )
    }
    
    private func removeNotificationObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupAction() {
        leftButton.addTarget(
            self,
            action: #selector(handleBackButtonTap),
            for: .touchUpInside
        )
        ellipsisButton.addTarget(
            self,
            action: #selector(handleEllipsisButtonTap),
            for: .touchUpInside
        )
    }
    
    // MARK: - Bind
    
    private func bind() {
        viewModel.$record
            .sink { [weak self] record in
                guard let self = self else { return }
                contentView.configure(with: record)
            }.store(in: &cancellables)
    }
    
    // MARK: - Action Methods
    
    @objc private func handleRecordsDidUpdate() {
        viewModel.updateRecord()
    }
    
    @objc private func handleBackButtonTap() {
        generateHaptic()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleEllipsisButtonTap() {
        generateHaptic()
        
        let recordMenuViewController = RecordMenuViewController(otherFlag: false)
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

extension RecordDetailViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

extension RecordDetailViewController: RecordMenuViewDelegate {
    func didRecordMenuTap(_ recordMenu: RecordMenu) {
        switch recordMenu {
        case .edit:
            let editViewModel = DIContainer.shared.makeEditViewModel(for: viewModel.record.id)
            let editViewController = EditViewController(
                viewModel: editViewModel,
                username: username
            )
            present(editViewController, animated: true)
        case .reminisce:
            break
        case .delete:
            showAlert(
                message: "정말 삭제하시겠어요?",
                leftActionText: "돌아가기",
                rightActionText: "삭제하기",
                rightActionCompletion: { [weak self] in
                    guard let self = self else { return }
                    removeNotificationObserver()
                    viewModel.deleteRecord()
                    navigationController?.popViewController(animated: true)
                }
            )
        default:
            break
        }
    }
}

private extension RecordDetailViewController {
    var ellipsisButton: UIButton {
        contentView.ellipsisButton
    }
}
