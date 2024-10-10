//
//  MyRecordView.swift
//  meant
//
//  Created by 지연 on 10/11/24.
//

import UIKit

import SnapKit

final class MyRecordView: UIView {
    private let homeTabs = HomeTab.allCases
    private var indicatorLeadingConstraint: Constraint?
    private var indicatorWidthConstraint: Constraint?
    private var isInitialLayoutCompleted = false
    
    // MARK: - UI Components
    
    let titleContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    }()
    
    let line: UIView = {
        let view = UIView()
        view.backgroundColor = .gray01
        return view
    }()
    
    let indicator: UIView = {
        let view = UIView()
        view.backgroundColor = .gray03
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        return scrollView
    }()
    
    lazy var contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let randomRecordView = RandomRecordView()
    
    let allRecordView = AllRecordView()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
        setupTitleContainer()
        setupScrollView()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if !isInitialLayoutCompleted {
            setupInitialIndicatorPosition()
            isInitialLayoutCompleted = true
        }
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        addSubview(titleContainer)
        titleContainer.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.left.equalToSuperview().inset(30)
            make.height.equalTo(20)
        }
        
        addSubview(line)
        line.snp.makeConstraints { make in
            make.top.equalTo(titleContainer.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        addSubview(indicator)
        indicator.snp.makeConstraints { make in
            make.centerY.equalTo(line)
            make.height.equalTo(3)
            self.indicatorLeadingConstraint = make.leading.equalTo(titleContainer).constraint
            self.indicatorWidthConstraint = make.width.equalTo(0).constraint
        }
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(titleContainer.snp.bottom).offset(15)
            make.left.right.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(scrollView)
        }
    }
    
    private func setupTitleContainer() {
        for (index, tab) in homeTabs.enumerated() {
            let label = createTitleLabel(with: tab.title)
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(titleTapped))
            label.addGestureRecognizer(tapGesture)
            label.tag = index
            titleContainer.addArrangedSubview(label)
        }
        
        let emptyView = UIView()
        titleContainer.addArrangedSubview(emptyView)
    }
    
    private func setupScrollView() {
        for (index, _) in homeTabs.enumerated() {
            let pageView: UIView
            switch index {
            case 0: pageView = randomRecordView
            case 1: pageView = allRecordView
            default: fatalError()
            }
            contentView.addArrangedSubview(pageView)
            
            pageView.snp.makeConstraints { make in
                make.width.equalTo(scrollView)
            }
        }
    }
    
    private func setupInitialIndicatorPosition() {
        guard let firstLabel = titleContainer.arrangedSubviews.first as? UILabel else { return }
        
        // 레이아웃을 강제로 업데이트
        layoutIfNeeded()
        
        // indicator의 위치와 너비를 첫 번째 레이블에 맞춤
        indicatorLeadingConstraint?.update(offset: firstLabel.frame.minX)
        indicatorWidthConstraint?.update(offset: firstLabel.frame.width)
        
        // 변경사항 즉시 적용
        UIView.performWithoutAnimation {
            self.layoutIfNeeded()
        }
    }
    
    @objc private func titleTapped(_ gesture: UITapGestureRecognizer) {
        guard let label = gesture.view as? UILabel else { return }
        let index = label.tag
        
        let xOffset = CGFloat(index) * scrollView.bounds.width
        scrollView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
    }
    
    private func updateIndicatorPosition(scrollProgress: CGFloat) {
        let fromIndex = Int(scrollProgress)
        let toIndex = min(fromIndex + 1, homeTabs.count - 1)
        let progress = scrollProgress - CGFloat(fromIndex)
        
        guard let fromLabel = titleContainer.arrangedSubviews[fromIndex] as? UILabel,
              let toLabel = titleContainer.arrangedSubviews[toIndex] as? UILabel else {
            return
        }
        
        let fromFrame = fromLabel.frame
        let toFrame = toLabel.frame
        
        let newWidth = fromFrame.width + (toFrame.width - fromFrame.width) * progress
        let newLeading = fromFrame.minX + (toFrame.minX - fromFrame.minX) * progress
        
        indicatorLeadingConstraint?.update(offset: newLeading)
        indicatorWidthConstraint?.update(offset: newWidth)
        
        layoutIfNeeded()
    }
}

private extension MyRecordView {
    func createTitleLabel(with title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textColor = .gray03
        label.font = .nanumSquareNeo(ofSize: 14.0, weight: .bold)
        return label
    }
}

extension MyRecordView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollProgress = scrollView.contentOffset.x / scrollView.bounds.width
        updateIndicatorPosition(scrollProgress: scrollProgress)
    }
}
