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
    case lisence
    case reset
    
    var title: String {
        switch self {
        case .name:         "이름 설정"
        case .notification: "알림 설정"
        case .lisence:      "오픈소스 라이선스"
        case .reset:        "데이터 초기화"
        }
    }
    
    var section: Int {
        switch self {
        case .name, .notification:  0
        case .lisence, .reset:      1
        }
    }
}

extension SettingsType {
    enum Mode {
        case none
        case chevron
        case switchControl
    }
    
    var mode: Mode {
        switch self {
        case .name, .lisence:    .chevron
        case .notification:      .switchControl
        case .reset:             .none
        }
    }
}
