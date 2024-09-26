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
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: RecordDetailViewModel) {
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
        setAction()
        bind()
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigationBar() {
        setNavigationBarStyle(.normalTitleWithBothButtons)
        // TODO: "나" 사용자 이름으로 바꾸기
        setNavigationBarTitle("나의 기록")
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
                    textView.isUserInteractionEnabled = true
                    textView.becomeFirstResponder()
                case .viewing:
                    setNavigationBarRightButtonIcon("pencil.line")
                    textView.isUserInteractionEnabled = false
                    if textView.text.isEmpty {
                        viewModel.toggleMode()
                        showAlert(message: "내용이 없으면 저장할 수 없어요.", actionText: "계속 작성하기")
                    } else {
                        viewModel.updateRecord(content: textView.text)
                    }
                }
            }.store(in: &cancellables)
    }
    
    // MARK: - Action Methods
    
    @objc private func handleDeleteButtonTap() {
        showAlert(
            message: "정말로 삭제하시겠어요?",
            leftActionText: "그만두기",
            rightActionText: "삭제하기",
            rightActionCompletion: { [weak self] in
                guard let self = self else { return }
                viewModel.deleteRecord()
                dismiss(animated: true)
            }
        )
    }
    
    @objc private func handleRightButtonTap() {
        viewModel.toggleMode()
    }
}

private extension RecordDetailViewController {
    var textView: MeantTextView {
        contentView.textView
    }
}
