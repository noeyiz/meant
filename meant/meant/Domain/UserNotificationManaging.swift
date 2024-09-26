//
//  UserNotificationManaging.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Foundation

protocol UserNotificationManaging {
    func checkNotificationAuthorization(completion: @escaping (Bool) -> Void)
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void)
    func scheduleNotification(for date: Date, message: String)
    func disableNotification()
}
