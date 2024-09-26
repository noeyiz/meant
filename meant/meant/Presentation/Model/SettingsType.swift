//
//  SettingsType.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import UIKit

enum SettingsType: CaseIterable {
    case name
    case notification
    case lock
    case instragram
    
    var title: String {
        switch self {
        case .name:         "이름 설정"
        case .notification: "알림 설정"
        case .lock:         "잠금 설정"
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
        case .name, .instragram:    .description
        case .notification, .lock:  .switchControl
        }
    }
}
