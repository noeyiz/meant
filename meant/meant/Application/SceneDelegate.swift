//
//  SceneDelegate.swift
//  meant
//
//  Created by 지연 on 9/24/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        // 알림 권한 설정
        let userSettingsRepository = UserSettingsRepository()
        UserNotificationManager.shared.requestAuthorization { isAuthorized, error in
            userSettingsRepository.notificationEnabled = isAuthorized
            if isAuthorized {
                UserNotificationManager.shared.scheduleNotification(
                    for: userSettingsRepository.notificationTime,
                    message: userSettingsRepository.notificationMessage
                )
            }
        }
        
        // 알림 센터의 delegate 설정
        UNUserNotificationCenter.current().delegate = self
        
        window = UIWindow(windowScene: windowScene)
        let homeViewModel = DIContainer.shared.makeHomeViewModel()
        window?.rootViewController = UINavigationController(
            rootViewController: HomeViewController(viewModel: homeViewModel)
        )
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}

extension SceneDelegate: UNUserNotificationCenterDelegate {
    // 앱이 포그라운드 상태일 때 알림이 도착하면 호출
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .list, .sound])
    }
}
