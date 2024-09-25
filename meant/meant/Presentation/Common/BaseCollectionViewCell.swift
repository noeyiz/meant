//
//  BaseCollectionViewCell.swift
//  meant
//
//  Created by 지연 on 9/25/24.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell, Reusable {
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
