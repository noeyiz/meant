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
    
    var message: String {
        switch self {
        case .confide:  "오늘 하루는 어땠나요?\n사용자님의 이야기를 들려주세요."
        case .gather:   "사용자님이 만난 반짝이는 문장,\n마음을 울린 순간을 기록해보세요."
        }
    }
}
