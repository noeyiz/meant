//
//  ReminiscenceCell.swift
//  meant
//
//  Created by 지연 on 10/11/24.
//

//import UIKit
//
//import SnapKit
//
//final class ReminiscenceCell: UITableViewCell, Reusable {
//    // MARK: - UI Components
//    
//    private let dateLabel = {
//        let label = UILabel()
//        label.font = .nanumSquareNeo(ofSize: 8.5)
//        label.textColor = .gray02
//        label.textAlignment = .right
//        return label
//    }()
//    
//    private let containerView = {
//        let view = UIView()
//        view.backgroundColor = .meant01
//        view.clipsToBounds = true
//        view.layer.cornerRadius = 12
//        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
//        return view
//    }()
//    
//    private let contentLabel = {
//        let label = UILabel()
//        label.font = .nanumSquareNeo(ofSize: 10.5)
//        label.textColor = .gray03
//        label.numberOfLines = 0
//        return label
//    }()
//    
//    // MARK: - Init
//    
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        
//        setupLayout()
//    }
//    
//    @available(*, unavailable)
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - Setup Methods
//    
//    private func setupLayout() {
//        contentView.addSubview(dateLabel)
//        dateLabel.snp.makeConstraints { make in
//            make.left.equalToSuperview()
//            make.bottom.equalToSuperview().inset(10)
//        }
//        
//        contentView.addSubview(containerView)
//        containerView.snp.makeConstraints { make in
//            make.top.bottom.equalToSuperview().inset(10)
//            make.right.equalToSuperview()
//            make.left.equalTo(dateLabel.snp.right).offset(10)
//        }
//        
//        containerView.addSubview(contentLabel)
//        contentLabel.snp.makeConstraints { make in
//            make.top.bottom.equalToSuperview().inset(15)
//            make.left.right.equalToSuperview().inset(20)
//        }
//    }
//    
//    // MARK: - Configure
//    
//    func configure(with reminiscence: Reminiscence) {
//        dateLabel.text = reminiscence.date.formatAsFullDate()
//        contentLabel.text = reminiscence.content
//    }
//}


import UIKit
import SnapKit

final class ReminiscenceCell: UITableViewCell, Reusable {
    // MARK: - UI Components
    
    private let dateLabel = {
        let label = UILabel()
        label.font = .nanumSquareNeo(ofSize: 8.5)
        label.textColor = .gray02
        label.textAlignment = .right
        return label
    }()
    
    private let containerView = {
        let view = UIView()
        view.backgroundColor = .meant01
        view.clipsToBounds = true
        view.layer.cornerRadius = 12
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner]
        return view
    }()
    
    private let contentLabel = {
        let label = UILabel()
        label.font = .nanumSquareNeo(ofSize: 10.5)
        label.textColor = .gray03
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Methods
    
    private func setupLayout() {
        contentView.addSubview(dateLabel)
        contentView.addSubview(containerView)
        containerView.addSubview(contentLabel)
        
        dateLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        dateLabel.snp.makeConstraints { make in
            make.left.greaterThanOrEqualToSuperview()
            make.bottom.equalToSuperview().inset(5)
        }
        
        containerView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.right.equalToSuperview()
            make.left.equalTo(dateLabel.snp.right).offset(5)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
    }
    
    // MARK: - Configure
    
    func configure(with reminiscence: Reminiscence) {
        dateLabel.text = reminiscence.date.formatAsFullDate()
        contentLabel.setTextWithLineHeight(reminiscence.content, lineHeight: 17.0)
    }
}
