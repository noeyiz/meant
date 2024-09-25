//
//  RecordCell.swift
//  meant
//
//  Created by 지연 on 9/25/24.
//

import UIKit

import SnapKit

final class RecordCell: BaseCollectionViewCell {
    // MARK: - UI Components
    
    private let backgroundImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.font = .nanumSquareNeo(ofSize: 10.5, weight: .regular)
        label.textColor = .gray03
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
        contentView.addSubview(backgroundImageView)
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backgroundImageView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(15)
        }
    }
    
    // MARK: - Configure
    
    func configure(with type: RecordType) {
        backgroundImageView.image = UIImage(named: type.rawValue)
        titleLabel.text = type.title
    }
}
