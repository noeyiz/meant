//
//  InstagramLinkHandler.swift
//  meant
//
//  Created by 지연 on 9/26/24.
//

import UIKit

final class InstragramLinkHandler {
    static let username="meant__app"
    
    static func openInstagramProfile() {
        let instagramAppURL = URL(string: "instagram://user?username=\(username)")!
        let instagramWebURL = URL(string: "https://www.instagram.com/\(username)")!
        
        if UIApplication.shared.canOpenURL(instagramAppURL) {
            UIApplication.shared.open(instagramAppURL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(instagramWebURL, options: [:], completionHandler: nil)
        }
    }
}
