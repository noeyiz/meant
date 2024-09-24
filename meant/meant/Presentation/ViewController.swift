//
//  ViewController.swift
//  meant
//
//  Created by 지연 on 9/24/24.
//

import UIKit

class ViewController: BaseViewController<View> {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        contentView.backgroundColor = .blue03
        setupNavigationBar()
    }

    private func setupNavigationBar() {
        setNavigationBarStyle(.largeTitleWithRightButton)
        setNavigationBarTitle("meant")
        setNavigationBarRightButtonIcon("gearshape")
        
//        setNavigationBarStyle(.normalTitleWithBothButtons)
//        setNavigationBarTitle("털어놓기")
//        setNavigationBarLeftButtonIcon("xmark")
//        setNavigationBarRightButtonIcon("checkmark")
    }
}

