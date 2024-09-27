//
//  SettingsType.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import UIKit

enum SettingsType: String, CaseIterable {
    case name
    case notification
    case reset
    case instragram
    
    var title: String {
        switch self {
        case .name:         "이름 설정"
        case .notification: "알림 설정"
        case .reset:        "데이터 초기화"
        case .instragram:   "인스타그램"
        }
    }
}

extension SettingsType {
    enum Mode {
        case description
        case switchControl
    }
    
    var mode: Mode {
        switch self {
        case .name, .reset, .instragram:    .description
        case .notification:                 .switchControl
        }
    }
}
