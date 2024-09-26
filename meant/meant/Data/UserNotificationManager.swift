//
//  UserNotificationManager.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import Foundation
import UserNotifications

final class UserNotificationManager: UserNotificationManaging {
    
    static let shared = UserNotificationManager()
    private let notificationCenter: UNUserNotificationCenter
    
    private init(notificationCenter: UNUserNotificationCenter = .current()) {
        self.notificationCenter = notificationCenter
    }
    
    func checkNotificationAuthorization(completion: @escaping (Bool) -> Void) {
        notificationCenter.getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(
                    settings.authorizationStatus == .authorized ||
                    settings.authorizationStatus == .provisional
                )
            }
        }
    }
    
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                completion(granted, error)
            }
        }
    }
    
    func scheduleNotification(for date: Date, message: String) {
        disableNotification()
        
        let content = UNMutableNotificationContent()
        content.title = "meant"
        content.body = message
        content.sound = .default
        
        let triggerDate = Calendar.current.dateComponents([.hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: true)
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Failed to add notification: \(error.localizedDescription)")
            }
        }
    }
    
    func disableNotification() {
        notificationCenter.removeAllPendingNotificationRequests()
    }
}
