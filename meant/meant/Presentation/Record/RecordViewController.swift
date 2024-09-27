//
//  RecordViewController.swift
//  meant
//
//  Created by 지연 on 9/25/24.
//

import UIKit

final class RecordViewController: BaseViewController<RecordView> {
    private let viewModel: RecordViewModel
    private let recordType: RecordType
    // MARK: - Init
    
    init(viewModel: RecordViewModel, recordType: RecordType, username: String) {
        self.viewModel = viewModel
        self.recordType = recordType
        
        super.init(nibName: nil, bundle: nil)
        
        contentView.configure(with: recordType, username)
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
        contentView.animateMessageAppearance()
    }
    
    // MARK: - Setup Methods
    
    private func setupNavigationBar() {
        setNavigationBarStyle(.normalTitleWithBothButtons)
        setNavigationBarTitle(recordType.title)
        setNavigationBarLeftButtonIcon("xmark")
        setNavigationBarRightButtonIcon("checkmark")
    }
    
    private func setupAction() {
        leftButton.addTarget(self, action: #selector(handleCancelButtonTap), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(handleDoneButtonTap), for: .touchUpInside)
    }
    
    // MARK: - Action Methods
    
    @objc private func handleCancelButtonTap() {
        generateHaptic()
        showAlert(
            message: recordType == .confide ?
            "아직 다 적지 않은 이야기가 있어요.\n정말 나가시겠어요?" :
            "소중한 조각들이 잊혀질지도 몰라요.\n정말 나가시겠어요?",
            leftActionText: "머무르기",
            rightActionText: "나가기",
            rightActionCompletion: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        )
    }
    
    @objc private func handleDoneButtonTap() {
        generateHaptic()
        if textView.text.isEmpty {
            showAlert(message: "빈 페이지엔 아무것도 남지 않아요.\n무언가를 남겨주세요.", actionText: "계속 쓰기")
        } else {
            viewModel.saveRecord(content: textView.text, recordType: recordType)
            navigationController?.popViewController(animated: true)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !textView.text.isEmpty {
            textView.endEditing(true)
        }
    }
}

private extension RecordViewController {
    var textView: MeantTextView {
        contentView.textView
    }
}
