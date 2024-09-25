//
//  HomeView.swift
//  meant
//
//  Created by 지연 on 9/25/24.
//

import UIKit

import SnapKit

final class HomeView: UIView {
    // MARK: - UI Components
    
    private lazy var recordLabel = createTitleLabel(with: "기록하기")
    
    lazy var recordCollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(cellType: RecordCell.self)
        return collectionView
    }()
    
    // TODO: "나" 사용자 이름으로 변경하기
    private lazy var myRecordLabel = createTitleLabel(with: "나의 기록")
    
    let myRecordView = UIView()
    
    // TODO: "사용자" 사용자 이름으로 변경하기
    lazy var emptyLabel = {
        let label = UILabel()
        label.text = "사용자님의 기록을 기다리고 있어요"
        label.font = .nanumSquareNeo(ofSize: 10.0)
        label.textColor = .gray02
        return label
    }()
    
    private let gradientView = UIView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // gradientView의 레이아웃이 잡힌 후 gradientLayer의 frame을 정할 수 있음
        setGradientView()
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(recordLabel)
        recordLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.left.equalToSuperview().inset(30)
        }
        
        addSubview(recordCollectionView)
        recordCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recordLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
            make.height.equalTo(70)
        }
        
        addSubview(myRecordLabel)
        myRecordLabel.snp.makeConstraints { make in
            make.top.equalTo(recordCollectionView.snp.bottom).offset(25)
            make.left.equalToSuperview().inset(30)
        }
        
        addSubview(emptyLabel)
        emptyLabel.snp.makeConstraints { make in
            make.top.equalTo(myRecordLabel.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
        }
        
        addSubview(myRecordView)
        myRecordView.snp.makeConstraints { make in
            make.top.equalTo(myRecordLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview().inset(30)
            make.bottom.equalToSuperview()
        }
        
        addSubview(gradientView)
        gradientView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(80)
        }
    }
}

// MARK: - Private Methods

private extension HomeView {
    func createTitleLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .gray03
        label.font = .nanumSquareNeo(ofSize: 14.0, weight: .bold)
        return label
    }
    
    func setGradientView() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.withAlphaComponent(0.0).cgColor,
                                UIColor.white.withAlphaComponent(1.0).cgColor]
        gradientLayer.frame = gradientView.bounds
        gradientLayer.locations = [0.0, 0.5]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientView.layer.addSublayer(gradientLayer)
    }
}
