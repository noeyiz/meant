//
//  LicenseView.swift
//  meant
//
//  Created by 지연 on 10/11/24.
//

import UIKit

import SnapKit

final class LicenseView: UIView {
    private let text = """
    이 앱은 네이버 나눔글꼴을 사용합니다.
    Copyright (c) 2010, NAVER Corporation (https://www.navercorp.com/)
    SIL Open Font License, Version 1.1에 따라 라이선스됨.
    라이선스 전문은 http://scripts.sil.org/OFL 에서 확인할 수 있습니다.
    """
    // MARK: - UI Components
    
    private lazy var label = {
        let label = UILabel()
        label.setTextWithLineHeight(text, lineHeight: 17.0)
        label.font = .nanumSquareNeo(ofSize: 8.5)
        label.textColor = .gray02
        label.textAlignment = .left
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
        addSubview(label)
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.left.right.equalToSuperview().inset(30)
        }
    }
}
