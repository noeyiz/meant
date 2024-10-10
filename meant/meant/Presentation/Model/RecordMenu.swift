//
//  RecordMenu.swift
//  meant
//
//  Created by 지연 on 10/11/24.
//

import UIKit

enum RecordMenu: CaseIterable {
    case edit
    case reminisce
    case other
    case delete
    
    var title: String {
        switch self {
        case .edit:         "수정하기"
        case .reminisce:    "마음 남기기"
        case .other:        "다른 기록 보기"
        case .delete:       "삭제하기"
        }
    }
    
    var iconName: String {
        switch self {
        case .edit:         "pencil.line"
        case .reminisce:    "message"
        case .other:        "arrow.clockwise"
        case .delete:       "trash"
        }
    }
}

extension RecordMenu {
    var color: UIColor {
        switch self {
        case .delete:   .warning
        default:        .gray03
        }
    }
}
