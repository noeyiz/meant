//
//  UIViewController+.swift
//  meant
//
//  Created by 지연 on 9/25/24.
//

import UIKit

extension UIViewController: HapticFeedbackable{}

extension UIViewController {
    func showAlert(
        message: String,
        leftActionText: String,
        rightActionText: String,
        leftActionCompletion: (() -> Void)? = nil,
        rightActionCompletion: (() -> Void)? = nil
    ) {
        let alertViewController = MeantAlertViewController(
            message: message,
            leftActionText: leftActionText,
            rightActionText: rightActionText,
            leftActionCompletion: leftActionCompletion,
            rightActionCompletion: rightActionCompletion
        )
        present(alertViewController, animated: false)
    }
    
    func showAlert(
        message: String,
        actionText: String,
        actionCompletion: (() -> Void)? = nil
    ) {
        let alertViewController = MeantAlertViewController(
            message: message,
            actionText: actionText,
            actionCompletion: actionCompletion
        )
        present(alertViewController, animated: false)
    }
}
