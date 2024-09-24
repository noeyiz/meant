//
//  HomeViewController.swift
//  meant
//
//  Created by 지연 on 9/25/24.
//

import Foundation

final class HomeViewController: BaseViewController<HomeView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        setNavigationBarStyle(.largeTitleWithRightButton)
        setNavigationBarTitle("meant")
        setNavigationBarRightButtonIcon("gearshape")
    }
}
