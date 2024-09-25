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
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func handleDoneButtonTap() {
        navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        contentView.endEditing(true)
    }
}
