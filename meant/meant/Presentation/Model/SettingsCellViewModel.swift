//
//  SettingsCellViewModel.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Foundation

struct SettingsCellViewModel {
    let type: SettingsType
    var isOn: Bool?
    
    init(type: SettingsType, isOn: Bool? = nil) {
        self.type = type
        self.isOn = isOn
    }
}
