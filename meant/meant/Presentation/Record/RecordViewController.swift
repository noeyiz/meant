//
//  RecordViewController.swift
//  meant
//
//  Created by 지연 on 9/25/24.
//

import UIKit

final class RecordViewController: BaseViewController<RecordView> {
    private let recordType: RecordType
    // MARK: - Init
    
    init(recordType: RecordType) {
        self.recordType = recordType
        
        super.init(nibName: nil, bundle: nil)
        
        contentView.configure(with: recordType)
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
        showAlert(
            message: recordType == .confide ?
            "오늘의 이야기가 아직 끝나지 않은 것 같아요.\n정말로 나가시겠어요?" :
            "조각을 모으지 않으면 잊혀질지도 몰라요.\n정말로 나가시겠어요?",
            leftActionText: "머무르기",
            rightActionText: "나가기",
            rightActionCompletion: { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        )
    }
    
    @objc private func handleDoneButtonTap() {
        if textView.text.isEmpty {
            showAlert(message: "내용이 없으면 저장할 수 없어요.", actionText: "계속 작성하기")
        } else {
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
