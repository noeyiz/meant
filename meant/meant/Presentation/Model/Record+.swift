//
//  Record+.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import UIKit

extension RecordType {
    var color01: UIColor {
        switch self {
        case .confide:  .blue01
        case .gather:   .green01
        }
    }
    
    var color02: UIColor {
        switch self {
        case .confide:  .blue03
        case .gather:   .green03
        }
    }
}
