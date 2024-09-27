//
//  RecordDetailViewController.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Combine
import UIKit

final class RecordDetailViewController: BaseViewController<RecordDetailView> {
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
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setAction()
        bind()
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigationBar() {
        setNavigationBarStyle(.normalTitleWithBothButtons)
        setNavigationBarTitle("\(username)의 기록")
        setNavigationBarLeftButtonIcon("trash")
        setNavigationBarRightButtonIcon("pencil.line")
    }
    
    private func setAction() {
        leftButton.addTarget(self, action: #selector(handleDeleteButtonTap), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(handleRightButtonTap), for: .touchUpInside)
    }
    
    private func bind() {
        textView.text = viewModel.record.content
        textView.tintColor = RecordType(rawValue: viewModel.record.type)!.color02
        
        viewModel.$mode
            .sink { [weak self] mode in
                guard let self = self else { return }
                switch mode {
                case .editing:
                    setNavigationBarRightButtonIcon("checkmark")
                    textView.isEditable = true
                    textView.becomeFirstResponder()
                case .viewing:
                    textView.isEditable = false
                    if textView.text.isEmpty {
                        showAlert(
                            message: "빈 페이지엔 아무것도 남지 않아요.\n무언가를 남겨주세요.",
                            actionText: "계속 쓰기",
                            actionCompletion: { self.viewModel.toggleMode() }
                        )
                    } else {
                        setNavigationBarRightButtonIcon("pencil.line")
                        viewModel.updateRecord(content: textView.text)
                    }
                }
            }.store(in: &cancellables)
    }
    
    // MARK: - Action Methods
    
    @objc private func handleDeleteButtonTap() {
        generateHaptic()
        showAlert(
            message: "정말 삭제하시겠어요?",
            leftActionText: "돌아가기",
            rightActionText: "삭제하기",
            rightActionCompletion: { [weak self] in
                guard let self = self else { return }
                viewModel.deleteRecord()
                dismiss(animated: true)
            }
        )
    }
    
    @objc private func handleRightButtonTap() {
        generateHaptic()
        viewModel.toggleMode()
    }
}

private extension RecordDetailViewController {
    var textView: MeantTextView {
        contentView.textView
    }
}
