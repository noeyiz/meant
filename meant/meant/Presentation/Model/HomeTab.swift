//
//  HomeTab.swift
//  meant
//
//  Created by 지연 on 10/10/24.
//

import Foundation

enum HomeTab: CaseIterable {
    case random
    case all
    
    var title: String {
        switch self {
        case .random:   "어느 날의 기록"
        case .all:      "모든 기록"
        }
    }
}
