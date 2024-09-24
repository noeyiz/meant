//
//  MeantFontWeight.swift
//  meant
//
//  Created by 지연 on 9/24/24.
//

import Foundation

protocol MeantFontWeight {
    var fontName: String { get }
}

enum NanumSquareNeoWeight: MeantFontWeight {
    case light
    case regular
    case bold
    case extraBold
    case heavy
    
    var fontName: String {
        switch self {
        case .light:        "NanumSquareNeo-aLt"
        case .regular:      "NanumSquareNeo-bRg"
        case .bold:         "NanumSquareNeo-cBd"
        case .extraBold:    "NanumSquareNeo-dEb"
        case .heavy:        "NanumSquareNeo-eHv"
        }
    }
}

enum NanumMyeongjoWeight: MeantFontWeight {
    case regular
    case bold
    case extraBold
    
    var fontName: String {
        switch self {
        case .regular:      "NanumMyeongjoOTF"
        case .bold:         "NanumMyeongjoOTFBold"
        case .extraBold:    "NanumMyeongjoOTFExtraBold"
        }
    }
}
