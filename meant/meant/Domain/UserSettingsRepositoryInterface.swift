//
//  UserSettingsRepositoryInterface.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Foundation

protocol UserSettingsRepositoryInterface {
    var username: String { get set }
    var notificationEnabled: Bool { get set }
    var notificatinTime: Date { get set }
}
