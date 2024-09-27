//
//  NameView.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import UIKit

import SnapKit

final class NameView: UIView {
    // MARK: - UI Components
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "meant에서 당신을 어떻게 부르면 좋을까요?"
        label.font = .nanumSquareNeo(ofSize: 13.0, weight: .bold)
        label.textColor = .gray03
        return label
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.setTextWithLineHeight(
            "이름은 당신만의 의미있는 공간을 만들어줄 거예요.\n언제든 바꿀 수 있어요.",
            lineHeight: 15.0
        )
        label.font = .nanumSquareNeo(ofSize: 10.5)
        label.textColor = .gray02
        return label
    }()
    
    let textField = {
        let textField = UITextField()
        textField.font = .nanumSquareNeo(ofSize: 12.0)
        textField.placeholder = "이름"
        textField.textColor = .gray03
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.clearButtonMode = .always
        textField.tintColor = .blue03
        return textField
    }()
    
    private let line = {
        let view = UIView()
        view.backgroundColor = .gray01
        return view
    }()
    
    let indicatorLabel = {
        let label = UILabel()
        label.text = "0/5"
        label.font = .nanumSquareNeo(ofSize: 10.0)
        label.textColor = .gray02
        return label
    }()
    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(30)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(30)
        }
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(25)
            make.left.right.equalToSuperview().inset(35)
            make.height.equalTo(40)
        }
        
        addSubview(line)
        line.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(1)
        }
        
        addSubview(indicatorLabel)
        indicatorLabel.snp.makeConstraints { make in
            make.top.equalTo(line.snp.bottom).offset(5)
            make.right.equalToSuperview().inset(30)
        }
    }
}
