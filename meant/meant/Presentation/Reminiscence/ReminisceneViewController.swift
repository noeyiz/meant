//
//  ReminisceneViewController.swift
//  meant
//
//  Created by 지연 on 10/11/24.
//

import Combine
import UIKit

final class ReminisceneViewController: BaseViewController<ReminiscenceView> {
    private let viewModel: ReminiscenceViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(viewModel: ReminiscenceViewModel) {
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
        bind()
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigationBar() {
        setNavigationBarStyle(.normalTitleWithBothButtons)
        setNavigationBarTitle("마음 남기기")
        setNavigationBarLeftButtonIcon("xmark")
        setNavigationBarRightButtonIcon("checkmark")
    }
    
    private func setupAction() {
        leftButton.addTarget(self, action: #selector(handleXButtonTap), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(handleCheckButtonTap), for: .touchUpInside)
    }
    
    private func setupTextView() {
        textView.tintColor = .meant02
        textView.becomeFirstResponder()
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
    
    @objc private func handleXButtonTap() {
        generateHaptic()
        if textView.text.isEmpty {
            dismiss(animated: true)
        } else {
            showAlert(
                message: "아직 담지 못한 마음이 있어요.\n정말 나가시겠어요?",
                leftActionText: "머무르기",
                rightActionText: "나가기",
                rightActionCompletion: { [weak self] in
                    self?.dismiss(animated: true)
                }
            )
        }
    }
    
    @objc private func handleCheckButtonTap() {
        generateHaptic()
        if textView.text.isEmpty {
            showAlert(message: "빈 페이지엔 아무것도 남지 않아요.\n무언가를 남겨주세요.", actionText: "계속 쓰기")
        } else {
            viewModel.saveReminiscence(content: textView.text)
            dismiss(animated: true)
        }
    }
}

private extension ReminisceneViewController {
    var textView: MeantTextView {
        contentView.textView
    }
}
