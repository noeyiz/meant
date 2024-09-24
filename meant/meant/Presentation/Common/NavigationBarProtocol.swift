//
//  NavigationBarProtocol.swift
//  meant
//
//  Created by 지연 on 9/24/24.
//

import UIKit

protocol NavigationBarProtocol {
    var titleLabel: UILabel { get }
    var leftButton: UIButton { get }
    var rightButton: UIButton { get }
    
    func setNavigationBarStyle(_ style: NavigationBarStyle)
    func setNavigationBarTitle(_ title: String)
    func setNavigationBarLeftButtonIcon(_ systemName: String)
    func setNavigationBarRightButtonIcon(_ systemName: String)
}
