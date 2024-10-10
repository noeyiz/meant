//
//  EditViewController.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Combine
import UIKit

final class EditViewController: BaseViewController<EditView> {
    private let viewModel: EditViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: EditViewModel) {
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
        setupTextView()
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigationBar() {
        setNavigationBarStyle(.normalTitleWithBothButtons)
        setNavigationBarTitle(viewModel.record.date.formatAsFullDate())
        setNavigationBarLeftButtonIcon("xmark")
        setNavigationBarRightButtonIcon("checkmark")
    }
    
    private func setupAction() {
        leftButton.addTarget(self, action: #selector(handleXButtonTap), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(handleCheckButtonTap), for: .touchUpInside)
    }
    
    private func setupTextView() {
        textView.text = viewModel.record.content
        textView.tintColor = RecordType(rawValue: viewModel.record.type)!.color02
        textView.becomeFirstResponder()
    }
    
    // MARK: - Action Methods
    
    @objc private func handleXButtonTap() {
        generateHaptic()
        showAlert(
            message: "정말 취소하시겠어요?\n변경된 내용은 저장되지 않아요.",
            leftActionText: "계속 쓰기",
            rightActionText: "취소하기",
            rightActionCompletion: { [weak self] in
                guard let self = self else { return }
                dismiss(animated: true)
            }
        )
    }
    
    @objc private func handleCheckButtonTap() {
        generateHaptic()
        if textView.text.isEmpty {
            showAlert(message: "빈 페이지엔 아무것도 남지 않아요.\n무언가를 남겨주세요.", actionText: "계속 쓰기")
        } else {
            viewModel.updateRecord(content: textView.text)
            dismiss(animated: true)
        }
    }
}

private extension EditViewController {
    var textView: MeantTextView {
        contentView.textView
    }
}
