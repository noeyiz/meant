//
//  BaseViewController.swift
//  meant
//
//  Created by 지연 on 9/24/24.
//

import UIKit

import SnapKit

class BaseViewController<View: UIView>: UIViewController, NavigationBarProtocol, UIGestureRecognizerDelegate {
    // MARK: - UI Components
    
    lazy var titleLabel = createLabel()
    lazy var leftButton = createButton()
    lazy var rightButton = createButton()
    let contentView = View()
    private let textureImageView = UIImageView(image: UIImage(named: "texture"))
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
    }
    
    // MARK: - Setup Methods
    
    func setNavigationBarStyle(_ style: NavigationBarStyle) {
        switch style {
        case .largeTitleWithRightButton:    configureLargeTitleStyle()
        case .normalTitleWithBothButtons:   configureNormalTitleStyle()
        }
    }
    
    func setNavigationBarTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setNavigationBarLeftButtonIcon(_ systemName: String) {
        leftButton.configuration?.image = UIImage(systemName: systemName)
    }
    
    func setNavigationBarRightButtonIcon(_ systemName: String) {
        rightButton.configuration?.image = UIImage(systemName: systemName)
    }
    
    // MARK: - Private Methods
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .gray03
        return label
    }
    
    private func createButton() -> UIButton {
        let button = UIButton()
        button.configuration = .plain()
        button.configuration?.contentInsets = .zero
        button.configuration?.preferredSymbolConfigurationForImage = .init(pointSize: 13.0)
        button.tintColor = .gray03
        return button
    }
    
    private func setupViewController() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        view.backgroundColor = .white
        
        setupLayout()
    }
    
    private func setupLayout() {
        view.addSubview(textureImageView)
        textureImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
            
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(60)
            make.left.bottom.right.equalToSuperview()
        }
    }
    
    private func configureLargeTitleStyle() {
        titleLabel.font = .nanumMyeongjo(ofSize: 28.0, weight: .bold)
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.bottom.equalTo(contentView.snp.top).offset(-10)
        }
        
        view.addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(30)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
    
    private func configureNormalTitleStyle() {
        titleLabel.font = .nanumSquareNeo(ofSize: 14.0, weight: .regular)
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(contentView.snp.top).offset(-20)
        }
        
        view.addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
        
        view.addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(30)
            make.centerY.equalTo(titleLabel.snp.centerY)
        }
    }
}

