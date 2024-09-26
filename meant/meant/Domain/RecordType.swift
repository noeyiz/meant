//
//  RecordType.swift
//  meant
//
//  Created by 지연 on 9/25/24.
//

import UIKit

enum RecordType: String, CaseIterable {
    case confide
    case gather
    
    var title: String {
        switch self {
        case .confide:  "털어놓기"
        case .gather:   "조각 모으기"
        }
    }
}
