//
//  MeantAlertViewController.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//
//

import UIKit
import SnapKit

final class MeantAlertViewController: UIViewController {
    private let buttonAttributes = AttributeContainer([
        .font: UIFont.nanumSquareNeo(ofSize: 11.0, weight: .bold)
    ])
    
    private var leftActionCompletion: (() -> Void)?
    private var rightActionCompletion: (() -> Void)?
    private var singleActionCompletion: (() -> Void)?
    
    // MARK: - UI Components
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .nanumSquareNeo(ofSize: 12.0)
        label.textColor = .gray03
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let buttonContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var leftButton = createButton()
    private lazy var rightButton = createButton()
    private lazy var singleButton = createButton()
    
    // MARK: - Init
    
    init(
        message: String,
        leftActionText: String,
        rightActionText: String,
        leftActionCompletion: (() -> Void)? = nil,
        rightActionCompletion: (() -> Void)? = nil
    ) {
        super.init(nibName: nil, bundle: nil)
        
        setupCommon()
        setupAlertView(
            message: message,
            leftActionText: leftActionText,
            rightActionText: rightActionText
        )
        setupActions(
            leftActionCompletion: leftActionCompletion,
            rightActionCompletion: rightActionCompletion
        )
    }
    
    init(message: String, actionText: String, actionCompletion: (() -> Void)? = nil) {
        super.init(nibName: nil, bundle: nil)
        
        setupCommon()
        setupAlertView(message: message, actionText: actionText)
        setupActions(singleActionCompletion: actionCompletion)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        prepareForAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateIn()
    }
    
    // MARK: - Setup Methods
    
    private func setupCommon() {
        view.backgroundColor = .gray03.withAlphaComponent(0.1)
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    private func setupAlertView(message: String, leftActionText: String, rightActionText: String) {
        messageLabel.setTextWithLineHeight(message)
        configureButton(leftButton, withTitle: leftActionText)
        configureButton(rightButton, withTitle: rightActionText)
        [leftButton, rightButton].forEach { buttonContainer.addArrangedSubview($0) }
    }
    
    private func setupAlertView(message: String, actionText: String) {
        messageLabel.setTextWithLineHeight(message)
        configureButton(singleButton, withTitle: actionText)
        buttonContainer.addArrangedSubview(singleButton)
    }
    
    private func setupActions(
        leftActionCompletion: (() -> Void)? = nil,
        rightActionCompletion: (() -> Void)? = nil
    ) {
        self.leftActionCompletion = leftActionCompletion
        self.rightActionCompletion = rightActionCompletion
        
        leftButton.addTarget(self, action: #selector(leftButtonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonTapped), for: .touchUpInside)
    }
    
    private func setupActions(singleActionCompletion: (() -> Void)? = nil) {
        self.singleActionCompletion = singleActionCompletion
        singleButton.addTarget(self, action: #selector(singleButtonTapped), for: .touchUpInside)
    }
    
    private func setupLayout() {
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalToSuperview().multipliedBy(0.15)
            make.center.equalToSuperview()
        }
        
        containerView.addSubview(buttonContainer)
        buttonContainer.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(45)
        }
        
        containerView.addSubview(messageLabel)
        messageLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(10)
            make.bottom.equalTo(buttonContainer.snp.top)
        }
    }
    
    // MARK: - Helper Methods
    
    private func createButton() -> UIButton {
        let button = UIButton()
        button.configuration = .plain()
        button.backgroundColor = .clear
        return button
    }
    
    private func configureButton(_ button: UIButton, withTitle title: String) {
        button.configuration?.attributedTitle = .init(title, attributes: buttonAttributes)
    }
    
    // MARK: - Animation Methods
    
    func prepareForAnimation() {
        view.alpha = 0
        containerView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
    }
    
    func animateIn(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseOut) { [weak self] in
            self?.view.alpha = 1.0
            self?.containerView.transform = .identity
        } completion: { _ in
            completion?()
        }
    }
    
    func animateOut(completion: (() -> Void)? = nil) {
        UIView.animate(withDuration: 0.1, delay: 0.0, options: .curveEaseIn) { [weak self] in
            self?.view.alpha = 0.0
        } completion: { _ in
            completion?()
        }
    }
    
    // MARK: - Action Methods
    
    @objc private func leftButtonTapped() {
        dismiss(animated: true, completion: leftActionCompletion)
    }
    
    @objc private func rightButtonTapped() {
        dismiss(animated: true, completion: rightActionCompletion)
    }
    
    @objc private func singleButtonTapped() {
        dismiss(animated: true, completion: singleActionCompletion)
    }
}

// MARK: - UIViewControllerTransitioningDelegate

extension MeantAlertViewController: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return AlertAnimator(alertViewController: self, isPresenting: true)
    }
    
    func animationController(
        forDismissed dismissed: UIViewController
    ) -> UIViewControllerAnimatedTransitioning? {
        return AlertAnimator(alertViewController: self, isPresenting: false)
    }
}

// MARK: - Unified Animator

class AlertAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let alertViewController: MeantAlertViewController
    private let isPresenting: Bool
    
    init(alertViewController: MeantAlertViewController, isPresenting: Bool) {
        self.alertViewController = alertViewController
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(
        using transitionContext: UIViewControllerContextTransitioning?
    ) -> TimeInterval {
        if isPresenting {
            return 0.2
        } else {
            return 0.1
        }
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            guard let toView = transitionContext.view(forKey: .to) else { return }
            transitionContext.containerView.addSubview(toView)
            alertViewController.prepareForAnimation()
            alertViewController.animateIn {
                transitionContext.completeTransition(true)
            }
        } else {
            alertViewController.animateOut {
                transitionContext.completeTransition(true)
            }
        }
    }
}
